//
//  TrackListing.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import SwiftUI

struct TrackList: View {
  
  let sourceTracks: [Int:[Track]]
  let sourceArtist: String
  
  var body: some View {
    VStack {
      ForEach(0..<sourceTracks.count, id: \.self) { discNumber in
        DiscTrackList(
          discNumber: discNumber,
          discTracks: sourceTracks[discNumber]!,
          showDiscNumber: sourceTracks.count > 1 ? true : false,
          sourceArtist: sourceArtist
        )
      }
      .padding(.bottom)
    }
  }
}
