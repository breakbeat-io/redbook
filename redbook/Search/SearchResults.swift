//
//  SearchResults.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 02/03/2021.
//

import SwiftUI
import Kingfisher
import HMV

struct SearchResults: View {

  let searchResults: [AppleMusicAlbum]
  let add: (_ albumId: String) -> Void
  
  var body: some View {
    // TODO: lots of view formatting here, is it needed?
    List(searchResults) { album in
      NavigationLink(
        destination: SourceDetail(viewModel: .init(), sourceId: album.id, showPlaybackLink: false)
          .toolbar {
            ToolbarItem(placement: .confirmationAction) {
              Button {
                add(album.id)
              } label: {
                Text("Add")
              }
            }
          }
      ) {
        HStack {
          KFImage(album.attributes!.artwork.url(forWidth: 50))
            .placeholder {
              RoundedRectangle(cornerRadius: CSS.cardCornerRadius)
                .fill(Color(UIColor.secondarySystemBackground))
            }
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(CSS.cardCornerRadius)
            .frame(width: 50)
          VStack(alignment: .leading) {
            Text(album.attributes?.name ?? "")
              .font(.headline)
              .lineLimit(1)
            Text(album.attributes?.artistName ?? "")
              .font(.subheadline)
              .lineLimit(1)
          }
        }
      }
      .contextMenu(ContextMenu(menuItems: {
        Button {
          add(album.id)
        } label: {
          Label("Add", systemImage: "plus")
        }
        Button {
          // TODO
        } label: {
          Label("Share", systemImage: "square.and.arrow.up")
        }
        .disabled(true)
      }))
    }
  }
}
