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
    sortDescriptors: [NSSortDescriptor(keyPath: \Collection.name, ascending: true)]
  ) private var collections: FetchedResults<Collection>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(collections) { collection in
          Section(header: Text(collection.name ?? "")) {
            ForEach(collection.albums?.allObjects as? [Album] ?? []) { album in
              Text(album.name ?? "")
            }
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationTitle("On Rotation")
    }
  }
}
