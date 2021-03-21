//
//  CDCollectionProvider.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 12/03/2021.
//

import Foundation
import CoreData
import Combine

class CDCollectionProvider: NSObject, ObservableObject {
  
  var collections = CurrentValueSubject<[CDCollection], Never>([])
  private let collectionFetchController: NSFetchedResultsController<CDCollection>
  
  static let shared: CDCollectionProvider = CDCollectionProvider()

  private override init() {
    
    let collectionFetchRequest: NSFetchRequest<CDCollection> = CDCollection.fetchRequest()
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


extension CDCollectionProvider: NSFetchedResultsControllerDelegate {
  public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let collections = controller.fetchedObjects as? [CDCollection] else { return }
    self.collections.value = collections
  }
}
