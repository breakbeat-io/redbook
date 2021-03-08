//
//  DataController.swift
//  Shared
//
//  Created by Greg Hepworth on 29/10/2020.
//

import CoreData
import SwiftUI
import os.log

class DataController: ObservableObject {
  
  static let shared = DataController()

  let container: NSPersistentCloudKitContainer
  
  private init(inMemory: Bool = false) {
    
    container = NSPersistentCloudKitContainer(name: "redbook")
    
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { storeDescription, error in
      if let error = error {
        fatalError("Fatal error loading store: \(error.localizedDescription)")
      }
    }
  }
  
  func bootstrap() {
    os_log("🔊 Bootstrapping")
    
    let onRotationFetch: NSFetchRequest<Collection> = Collection.fetchRequest()
    onRotationFetch.predicate = NSPredicate(format: "type == %@", "onRotation")
    var onRotationCount: Int
    
    do {
      onRotationCount = try container.viewContext.count(for: onRotationFetch)
    } catch {
      os_log("🔊 On Rotation count threw an error!")
      fatalError()
    }
    
    switch onRotationCount {
    case 0:
      os_log("🔊 No On Rotation collection found .. creating ...")
      createOnRotation()
    case 1:
      os_log("🔊 Found a single On Rotation collection.")
    case 2...:
      os_log("🔊 Found \(onRotationCount) existing On Rotation collections ... validating ...")
      validateOnRotation()
    default:
      fatalError()
    }
  }
  
  private func validateOnRotation() {
    os_log("🔊 Validating On Rotation ... NOT IMPLEMENTED")
  }
  
  private func createOnRotation() {
    os_log("🔊 Creating On Rotation collection ...")
    
    let viewContext = container.viewContext
    
    let onRotation = Collection(context: viewContext)
    onRotation.type = "onRotation"
    onRotation.name = "On Rotation"
    onRotation.slots = []
    onRotation.curator = "Music Lover"
    for i in 1...8 {
      let slot = Slot(context: viewContext)
      slot.collection = onRotation
      slot.position = Int16(i)
    }
    
    do {
      try viewContext.save()
    } catch {
      fatalError()
    }
    
  }
  
  func save() {
    if container.viewContext.hasChanges {
      try? container.viewContext.save()
    }
  }
  
  func delete(_ object: NSManagedObject) {
    container.viewContext.delete(object)
  }
  
  func deleteAll() {
    
    let sourceFetch: NSFetchRequest<NSFetchRequestResult> = Source.fetchRequest()
    let sourceBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: sourceFetch)
    _ = try? container.viewContext.execute(sourceBatchDeleteRequest)
    
    let slotFetch: NSFetchRequest<NSFetchRequestResult> = Slot.fetchRequest()
    let slotBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: slotFetch)
    _ = try? container.viewContext.execute(slotBatchDeleteRequest)
    
    let collectionFetch: NSFetchRequest<NSFetchRequestResult> = Collection.fetchRequest()
    let collectionBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: collectionFetch)
    _ = try? container.viewContext.execute(collectionBatchDeleteRequest)

  }
  
  func createSampleData() throws {

    let viewContext = container.viewContext
    
    let onRotation = Collection(context: viewContext)
    onRotation.type = "onRotation"
    onRotation.name = "On Rotation"
    onRotation.slots = []
    onRotation.curator = "@iamhepto"

    for i in 1...8 {
      let slot = Slot(context: viewContext)
      slot.collection = onRotation
      slot.position = Int16(i)
      
      let source = Source(context: viewContext)
      source.title = "Album \(i)"
      source.artist = "iamhepto"
      source.playbackURL = URL(string: "https://itunes.apple.com/us/album/born-to-run/id310730204")
      source.artworkURL = URL(string: "https://picsum.photos/500/500?random=\(i)")
      
      slot.source = source
    }

    try viewContext.save()

  }
  
}
