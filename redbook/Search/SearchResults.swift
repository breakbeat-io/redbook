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
  
  let searchResults: [Album]
  
  var body: some View {
    // TODO: lots of view formatting here, is it needed?
    List(searchResults) { album in
      NavigationLink(destination: AlbumDetail(viewModel: .init(), albumId: album.id)) {
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
            // TODO: forced unwraps
            Text(album.attributes!.name)
              .font(.headline)
              .lineLimit(1)
            Text(album.attributes!.artistName)
              .font(.subheadline)
              .lineLimit(1)
          }
          Spacer()
          // TODO: feels like a bit of a cheat to use a button but with an onTap... to get around the NavigationLink stealing the tap
          Button { } label: {
            Text(Image(systemName: "plus"))
              .padding()
              .foregroundColor(.secondary)
          }
          .onTapGesture(perform: {
            print("hello")
          })
        }
      }
    }
  }
}
