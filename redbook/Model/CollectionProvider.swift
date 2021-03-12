//
//  CollectionProvider.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 12/03/2021.
//

import Foundation
import CoreData
import Combine

class CollectionProvider: NSObject, ObservableObject {
  
  var collections = CurrentValueSubject<[Collection], Never>([])
  private let collectionFetchController: NSFetchedResultsController<Collection>
  
  static let shared: CollectionProvider = CollectionProvider()

  private override init() {
    
    let collectionFetchRequest: NSFetchRequest<Collection> = Collection.fetchRequest()
    collectionFetchRequest.sortDescriptors = []
    
    collectionFetchController = NSFetchedResultsController(
      fetchRequest: collectionFetchRequest,
      managedObjectContext: PersistenceController.shared.container.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    
    super.init()
    
    collectionFetchController.delegate = self
    
    do {
      try collectionFetchController.performFetch()
      collections.value = collectionFetchController.fetchedObjects ?? []
    } catch {
      fatalError()
    }
    
  }

}


extension CollectionProvider: NSFetchedResultsControllerDelegate {
  public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let collections = controller.fetchedObjects as? [Collection] else { return }
    self.collections.value = collections
  }
}
