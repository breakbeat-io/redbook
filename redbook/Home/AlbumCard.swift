//
//  AlbumCard.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI
import Kingfisher

struct AlbumCard: View {
  
  let albumName: String
  let albumArtist: String
  let albumArtworkURL: URL
  
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .background(
        KFImage(albumArtworkURL)
          .placeholder {
            RoundedRectangle(cornerRadius: CSS.cardCornerRadius)
              .fill(Color(UIColor.secondarySystemBackground))
          }
          .renderingMode(.original)
          .resizable()
          .scaledToFill()
      )
      .cornerRadius(CSS.cardCornerRadius)
      .overlay(
        VStack(alignment: .leading) {
          Text(albumName)
            .font(.callout)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.top, 4)
            .padding(.horizontal, 6)
            .lineLimit(1)
          Text(albumArtist)
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal, 6)
            .padding(.bottom, 4)
            .lineLimit(1)
        }
        .background(Color.black.opacity(0.8))
        .cornerRadius(CSS.cardCornerRadius)
        .padding(4)
        , alignment: .bottomLeading)
      .shadow(radius: 3)
  }
}
