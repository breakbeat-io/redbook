//
//  OnRotation.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI
import CoreData

struct OnRotation: View {
  
  @StateObject var viewModel: ViewModel
  
  var body: some View {
    NavigationView {
      ScrollView {
        ForEach(viewModel.slots) { slot in
          if slot.source != nil {
            Button {
              
            } label: {
              SourceCard(title: slot.source!.title!, artist: slot.source!.artist!, artworkURL: slot.source!.artworkURL!)
                .frame(height: 61)
            }
          } else {
            EmptyCard(slotPosition: Int(slot.position))
              .frame(height: 61)
          }
        }
      }
      .padding(.horizontal)
      .navigationTitle("On Rotation")
      .toolbar {
        ToolbarItem(placement: .destructiveAction) {
          Button {
            viewModel.resetStore()
          } label: {
            Text("Reset")
          }
        }
      }
    }

  }
}

extension OnRotation {
  class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    let coreDataStore = DataController.shared.container.viewContext
    
    private let onRotationSlotsController: NSFetchedResultsController<Slot>
    @Published var slots = [Slot]()
    
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
      if let newOnRotationSlots = controller.fetchedObjects as? [Slot] {
        slots = newOnRotationSlots
      }
    }
    
    func resetStore() {
      DataController.shared.deleteAll()
      exit(1)
    }
    
  }
}
