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
          EmptyCard()
            .frame(height: 61)
        }
      }
      .padding(.horizontal)
      .navigationTitle("On Rotation")
    }
    .onAppear() {
      viewModel.loadSlots()
    }
  }
}

extension OnRotation {
  class ViewModel: ObservableObject {
    
    let coreDataStore = DataController.shared.container.viewContext
    
    @Published private(set) var slots: [Slot] = []
    
    func loadSlots() {
      let onRotationFetch: NSFetchRequest<Collection> = Collection.fetchRequest()
      onRotationFetch.predicate = NSPredicate(format: "type == %@", "onRotation")
      
      do {
        let onRotation = try coreDataStore.fetch(onRotationFetch).first
        let unorderedSlots = onRotation?.slots?.allObjects as? [Slot] ?? []
        slots = unorderedSlots.sorted(by: { $0.position < $1.position })
      } catch {
        fatalError()
      }
    }
    
  }
}
