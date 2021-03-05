//
//  TrackListing.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import SwiftUI
import HMV

struct TrackList: View {
  
  let albumTracks: [Track]
  let albumArtist: String
  private var numberOfDiscs: Int {
    albumTracks.map { $0.attributes?.discNumber ?? 1 }.max() ?? 1
  }
  
  var body: some View {
    VStack {
      ForEach(1...numberOfDiscs, id: \.self) { discNumber in
        DiscTrackList(
          discNumber: discNumber,
          discTracks: self.albumTracks.filter { $0.attributes?.discNumber == discNumber }, // TODO: should this move out instead of inline?
          showDiscNumber: numberOfDiscs > 1 ? true : false,
          albumArtist: albumArtist
        )
      }
      .padding(.bottom)
    }
  }
}
