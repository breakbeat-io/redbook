//
//  SourceCover.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import SwiftUI
import Kingfisher

struct SourceCover: View {
  
  let sourceName: String
  let sourceArtist: String
  var sourceArtworkURL: URL
  
  var body: some View {
    // TODO: lots of formatting here, is it needed?
    VStack(alignment: .leading) {
      KFImage(sourceArtworkURL)
        .placeholder {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color(UIColor.secondarySystemBackground))
        }
        .resizable()
        .aspectRatio(contentMode: .fit)
        .cornerRadius(4)
        .shadow(radius: 4)
      Group {
        Text(sourceName)
          .fontWeight(.bold)
        Text(sourceArtist)
      }
      .font(.title)
      .lineLimit(1)
    }
  }
}
