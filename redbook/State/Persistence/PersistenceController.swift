//
//  PersistenceController.swift
//  Shared
//
//  Created by Greg Hepworth on 29/10/2020.
//

import CoreData
import SwiftUI
import os.log

struct PersistenceController {
  
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
    container.viewContext.automaticallyMergesChangesFromParent = true
    
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
    
    let profileFetch: NSFetchRequest<NSFetchRequestResult> = PersistentProfile.fetchRequest()
    let profileBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: profileFetch)
    _ = try? container.viewContext.execute(profileBatchDeleteRequest)
    
    let sourceFetch: NSFetchRequest<NSFetchRequestResult> = PersistentSource.fetchRequest()
    let sourceBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: sourceFetch)
    _ = try? container.viewContext.execute(sourceBatchDeleteRequest)
    
    let slotFetch: NSFetchRequest<NSFetchRequestResult> = PersistentSlot.fetchRequest()
    let slotBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: slotFetch)
    _ = try? container.viewContext.execute(slotBatchDeleteRequest)
    
    let collectionFetch: NSFetchRequest<NSFetchRequestResult> = PersistentCollection.fetchRequest()
    let collectionBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: collectionFetch)
    _ = try? container.viewContext.execute(collectionBatchDeleteRequest)

  }
  
}
