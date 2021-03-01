//
//  OnRotation.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI

struct OnRotation: View {
  
  @FetchRequest(
    entity: Collection.entity(),
    sortDescriptors: [],
    predicate: NSPredicate(format: "onRotationLibrary != nil")
  ) private var onRotation: FetchedResults<Collection>
  
  private var slots: [Slot] {
    onRotation.first?.slots?.allObjects as? [Slot] ?? []
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        ForEach(slots.sorted(by: { $0.position < $1.position })) { slot in
          EmptyCard()
            .frame(height: 61)
        }
      }
      .padding(.horizontal)
      .navigationTitle("On Rotation")
    }
  }
}
