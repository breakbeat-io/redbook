//
//  AlbumArtwork.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import SwiftUI
import Kingfisher

struct AlbumCover: View {
  
  let albumName: String
  let albumArtist: String
  var albumArtwork: URL
  
  var body: some View {
    // TODO: lots of formatting here, is it needed?
    VStack(alignment: .leading) {
      KFImage(albumArtwork)
        .placeholder {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color(UIColor.secondarySystemBackground))
        }
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(4)
        .shadow(radius: 4)
      Group {
        Text(albumName)
          .fontWeight(.bold)
        Text(albumArtist)
      }
      .font(.title)
      .lineLimit(1)
    }
  }
}
