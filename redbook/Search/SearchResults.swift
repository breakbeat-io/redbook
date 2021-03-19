//
//  SearchResults.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 02/03/2021.
//

import SwiftUI
import Kingfisher

struct SearchResults: View {
  
  private let searchResults: [Source]
  private let add: (String) -> Void
  
  var body: some View {
    // TODO: lots of view formatting here, is it needed?
    List(searchResults) { source in
      NavigationLink(
        destination: SourceDetail(sourceId: source.sourceProviderId, showPlaybackLink: false)
          .toolbar {
            ToolbarItem(placement: .confirmationAction) {
              Button {
                add(source.sourceProviderId)
              } label: {
                Text("Add")
              }
            }
          }
      ) {
        HStack {
          KFImage(source.sourceArtworkURL)
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
            Text(source.sourceName)
              .font(.headline)
              .lineLimit(1)
            Text(source.sourceArtist)
              .font(.subheadline)
              .lineLimit(1)
          }
        }
      }
      .contextMenu(ContextMenu(menuItems: {
        Button {
          add(source.sourceProviderId)
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
  
  init(searchResults: [Source], addAction: @escaping (String) -> Void) {
    self.searchResults = searchResults
    self.add = addAction
  }
}
