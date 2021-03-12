//
//  SlotProvider.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 12/03/2021.
//

import Foundation
import CoreData
import Combine

class SlotProvider: NSObject, ObservableObject {
  
  var slots = CurrentValueSubject<[Slot], Never>([])
  private let slotFetchController: NSFetchedResultsController<Slot>
  
  static let shared: SlotProvider = SlotProvider()

  private override init() {
    
    let slotFetchRequest: NSFetchRequest<Slot> = Slot.fetchRequest()
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
  
  func delete(source: Source) {
    PersistenceController.shared.container.viewContext.delete(source)
    try? PersistenceController.shared.container.viewContext.save()
  }
  
}


extension SlotProvider: NSFetchedResultsControllerDelegate {
  public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let slots = controller.fetchedObjects as? [Slot] else { return }
    self.slots.value = slots
  }
}
