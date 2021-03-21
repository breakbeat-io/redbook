//
//  CDSlotProvider.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 12/03/2021.
//

import Foundation
import CoreData
import Combine

class CDSlotProvider: NSObject, ObservableObject {
  
  var slots = CurrentValueSubject<[CDSlot], Never>([])
  private let slotFetchController: NSFetchedResultsController<CDSlot>

  init(restrictToCollectionType collectionType: String = "") {
    
    let slotFetchRequest: NSFetchRequest<CDSlot> = CDSlot.fetchRequest()
    if !collectionType.isEmpty {
      slotFetchRequest.predicate = NSPredicate(format: "collection.type = %@", collectionType)
    }
    slotFetchRequest.sortDescriptors = []
    
    slotFetchController = NSFetchedResultsController(
      fetchRequest: slotFetchRequest,
      managedObjectContext: PersistenceController.shared.container.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    
    super.init()
    
    slotFetchController.delegate = self
    
    do {
      try slotFetchController.performFetch()
      slots.value = slotFetchController.fetchedObjects ?? []
    } catch {
      fatalError()
    }
    
  }
  
  func delete(source: CDSource) {
    PersistenceController.shared.container.viewContext.delete(source)
    try? PersistenceController.shared.container.viewContext.save()
  }
  
}


extension CDSlotProvider: NSFetchedResultsControllerDelegate {
  public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let slots = controller.fetchedObjects as? [CDSlot] else { return }
    self.slots.value = slots
  }
}
