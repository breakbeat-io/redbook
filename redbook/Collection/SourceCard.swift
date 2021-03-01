//
//  AlbumCard.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI
import Kingfisher

struct SourceCard: View {
  
  let title: String
  let artist: String
  let artworkURL: URL
  
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .background(
        KFImage(artworkURL)
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
          Text(title)
            .font(.callout)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.top, 4)
            .padding(.horizontal, 6)
            .lineLimit(1)
          Text(artist)
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
