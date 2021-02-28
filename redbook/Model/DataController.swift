//
//  DataController.swift
//  Shared
//
//  Created by Greg Hepworth on 29/10/2020.
//

import CoreData
import SwiftUI

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

    let collection = Collection(context: viewContext)
    collection.name = "On Rotation"
    collection.slots = []
    collection.curator = "@iamhepto"

    for j in 1...8 {
      let slot = Slot(context: viewContext)
      slot.collection = collection
      slot.position = Int16(j)
      
      let source = Source(context: viewContext)
      source.title = "Album \(j)"
      source.artist = "iamhepto"
      source.playbackURL = URL(string: "https://itunes.apple.com/us/album/born-to-run/id310730204")
      source.artworkURL = URL(string: "https://picsum.photos/500/500?random=\(j)")
      
      slot.source = source
    }

    try viewContext.save()

  }
  
}
