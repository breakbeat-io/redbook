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
    entity: Collection.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Collection.name, ascending: true)]
  ) private var collections: FetchedResults<Collection>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(collections) { collection in
          ForEach(collection.albums?.allObjects as? [Album] ?? []) { album in
            AlbumCard(albumName: album.name ?? "",
                      albumArtist: album.artist ?? "",
                      albumArtworkURL: (album.artworkURL ?? URL(string: "https://picsum.photos/500/500"))!)
              .frame(height: 61)
          }
        }
      }
      .navigationTitle("On Rotation")
    }
  }
}
