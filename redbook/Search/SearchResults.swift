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
  
  // TODO: not sure here what the property wrapper should be but this follows what i think docs say as I want to observe it but is owned by someone else ...
  @ObservedObject var viewModel: Search.ViewModel
  @Binding var isPresented: Bool
  
  var body: some View {
    // TODO: lots of view formatting here, is it needed?
    List(viewModel.searchResults) { album in
      NavigationLink(
        destination: AlbumDetail(viewModel: .init(), albumId: album.id, showPlaybackLink: false)
          .toolbar {
            ToolbarItem(placement: .confirmationAction) {
              Button {
                viewModel.addAlbumToSlot(albumId: album.id)
                isPresented = false
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
          viewModel.addAlbumToSlot(albumId: album.id)
        } label: {
          Label("Add", systemImage: "plus")
        }
        Button {
          //
        } label: {
          Label("Share", systemImage: "square.and.arrow.up")
        }
        .disabled(true)
      }))
    }
  }
}
