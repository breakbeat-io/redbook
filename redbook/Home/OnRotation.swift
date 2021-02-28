//
//  OnRotation.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI

struct OnRotation: View {
  
  // here should just get the one Collection that is of O On Rotation type
  @FetchRequest(
    entity: Library.entity(), sortDescriptors: []
  ) private var libraries: FetchedResults<Library>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(libraries) { library in
          let slots = library.onRotation?.slots?.allObjects as? [Slot] ?? []
          ForEach(slots.sorted(by: { $0.position < $1.position })) { slot in
            SourceCard(title: slot.source?.title ?? "",
                       artist: slot.source?.artist ?? "",
                       artworkURL: (slot.source?.artworkURL ?? URL(string: "https://picsum.photos/500/500"))!)
              .frame(height: 61)
          }
        }
        
      }
      .navigationTitle("On Rotation")
    }
  }
}
