//
//  CoreDataEntityPublisher.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 21/03/2021.
//

import Foundation
import CoreData
import Combine

class CoreDataEntityPublisher<T: NSManagedObject>: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
  
  var entities = CurrentValueSubject<[T], Never>([])
  private let entityFetchController: NSFetchedResultsController<T>

  override init() {
    
    let entityFetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
    entityFetchRequest.sortDescriptors = []
    
    entityFetchController = NSFetchedResultsController<T>(
      fetchRequest: entityFetchRequest,
      managedObjectContext: PersistenceController.shared.container.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    
    super.init()
    
    entityFetchController.delegate = self
    
    do {
      try entityFetchController.performFetch()
      entities.value = entityFetchController.fetchedObjects ?? []
    } catch {
      fatalError()
    }
    
  }
  
  public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let entities = controller.fetchedObjects as? [T] else { return }
    self.entities.value = entities
  }

}
