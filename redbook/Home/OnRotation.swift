//
//  OnRotation.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI
import CoreData

struct OnRotation: View {
  
  @StateObject private var model = OnRotationViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView {
        ForEach(model.slots) { slot in
          EmptyCard()
            .frame(height: 61)
        }
      }
      .padding(.horizontal)
      .navigationTitle("On Rotation")
    }
    .onAppear() {
      model.getSlots()
    }
  }
}


class OnRotationViewModel: ObservableObject {
  
  let moc = DataController.shared.container.viewContext
  
  @Published var slots: [Slot] = []
  
  func getSlots() {
    let onRotationFetch: NSFetchRequest<Collection> = Collection.fetchRequest()
    onRotationFetch.predicate = NSPredicate(format: "onRotationLibrary != nil")
    
    do {
      let onRotation = try moc.fetch(onRotationFetch)
      let tempSlots = onRotation.first?.slots?.allObjects as? [Slot] ?? []
      slots = tempSlots.sorted(by: { $0.position < $1.position })
    } catch {
      fatalError()
    }
  }
  
}
