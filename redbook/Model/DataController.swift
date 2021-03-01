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

  let container: NSPersistentCloudKitContainer
  
  static var preview: DataController = {
    let dataController = DataController(inMemory: true)
    let viewContext = dataController.container.viewContext

    do {
      try dataController.createSampleData()
    } catch {
      fatalError("Fatal error creating preview: \(error.localizedDescription)")
    }

    return dataController
  }()
  
  init(inMemory: Bool = false) {
    
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
    
    let librariesFetch: NSFetchRequest<NSFetchRequestResult> = Library.fetchRequest()
    var libraryCount: Int
    
    do {
      libraryCount = try container.viewContext.count(for: librariesFetch)
    } catch {
      os_log("🔊 Library count threw an error!")
      fatalError()
    }
    
    if libraryCount > 0 {
      os_log("🔊 Found \(libraryCount) existing Libraries!")
      validateLibrary()
    } else {
      os_log("🔊 No Library!")
      createLibrary()
    }
  }
  
  private func validateLibrary() {
    os_log("🔊 Validating Library!")
  }
  
  private func createLibrary() {
    os_log("🔊 Creating Library!")
    
    let viewContext = container.viewContext
    
    let onRotation = Collection(context: viewContext)
    onRotation.name = "On Rotation"
    onRotation.slots = []
    onRotation.curator = "Music Lover"
    for i in 1...8 {
      let slot = Slot(context: viewContext)
      slot.collection = onRotation
      slot.position = Int16(i)
    }
    
    let library = Library(context: viewContext)
    library.onRotation = onRotation
    
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
    let fetchAllAlbums: NSFetchRequest<NSFetchRequestResult> = Source.fetchRequest()
    let batchDeleteAlbums = NSBatchDeleteRequest(fetchRequest: fetchAllAlbums)
    _ = try? container.viewContext.execute(batchDeleteAlbums)
    
    let fetchAllCollections: NSFetchRequest<NSFetchRequestResult> = Collection.fetchRequest()
    let batchDeleteCollections = NSBatchDeleteRequest(fetchRequest: fetchAllCollections)
    _ = try? container.viewContext.execute(batchDeleteCollections)
  }
  
  func createSampleData() throws {

    let viewContext = container.viewContext
    
    let library = Library(context: viewContext)
    
    let onRotation = Collection(context: viewContext)
    onRotation.name = "On Rotation"
    onRotation.slots = []
    onRotation.curator = "@iamhepto"
    
    library.onRotation = onRotation

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
