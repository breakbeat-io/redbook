//
//  PersistenceController.swift
//  Shared
//
//  Created by Greg Hepworth on 29/10/2020.
//

import CoreData
import SwiftUI
import os.log

class PersistenceController {
  
  static let shared = PersistenceController()

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
    
    let onRotationFetch: NSFetchRequest<CDCollection> = CDCollection.fetchRequest()
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
    
    let onRotation = CDCollection(context: viewContext)
    onRotation.type = "onRotation"
    onRotation.name = "On Rotation"
    onRotation.slots = []
    onRotation.curator = "Music Lover"
    for i in 1...8 {
      let slot = CDSlot(context: viewContext)
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
    
    let sourceFetch: NSFetchRequest<NSFetchRequestResult> = CDSource.fetchRequest()
    let sourceBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: sourceFetch)
    _ = try? container.viewContext.execute(sourceBatchDeleteRequest)
    
    let slotFetch: NSFetchRequest<NSFetchRequestResult> = CDSlot.fetchRequest()
    let slotBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: slotFetch)
    _ = try? container.viewContext.execute(slotBatchDeleteRequest)
    
    let collectionFetch: NSFetchRequest<NSFetchRequestResult> = CDCollection.fetchRequest()
    let collectionBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: collectionFetch)
    _ = try? container.viewContext.execute(collectionBatchDeleteRequest)

  }
  
}
