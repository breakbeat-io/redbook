//
//  TrackListing.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import SwiftUI
import HMV

struct TrackList: View {
  
  let albumTracks: [Int:[Track]]
  let albumArtist: String
  
  var body: some View {
    VStack {
      ForEach(1...albumTracks.count, id: \.self) { discNumber in
        DiscTrackList(
          discNumber: discNumber,
          discTracks: albumTracks[discNumber]!,
          showDiscNumber: albumTracks.count > 1 ? true : false,
          albumArtist: albumArtist
        )
      }
      .padding(.bottom)
    }
  }
}
