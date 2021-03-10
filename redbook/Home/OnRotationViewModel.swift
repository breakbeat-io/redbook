//
//  OnRotationViewModel.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 10/03/2021.
//

import Foundation
import CoreData

extension OnRotation {
  class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    let coreDataStore = DataController.shared.container.viewContext
    
    @Published var slots = [Slot]()
    private let onRotationSlotsController: NSFetchedResultsController<Slot>
    
    override init() {
      let onRotationSlotsFetch: NSFetchRequest<Slot> = Slot.fetchRequest()
      onRotationSlotsFetch.sortDescriptors = [NSSortDescriptor(keyPath: \Slot.position, ascending: true)]
      onRotationSlotsFetch.predicate = NSPredicate(format: "collection.type = %@", "onRotation")
      
      onRotationSlotsController = NSFetchedResultsController(
        fetchRequest: onRotationSlotsFetch,
        managedObjectContext: coreDataStore,
        sectionNameKeyPath: nil,
        cacheName: nil
      )
      
      super.init()
      onRotationSlotsController.delegate = self
      
      do {
        try onRotationSlotsController.performFetch()
        slots = onRotationSlotsController.fetchedObjects ?? []
      } catch {
        fatalError()
      }
      
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      if let changedOnRotationSlots = controller.fetchedObjects as? [Slot] {
        slots = changedOnRotationSlots
      }
    }
    
    func removeSource(source: Source) {
      coreDataStore.delete(source)
      // TODO: this works, but if I call it in delete instead it doesn't - dunno why but wanna know!
      try? coreDataStore.save()
    }
    
    // TODO: remove as temporary until delete is implemented
    func resetStore() {
      DataController.shared.deleteAll()
      exit(1)
    }
    
  }
}
