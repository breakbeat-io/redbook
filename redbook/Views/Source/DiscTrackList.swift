//
//  DiscTrackList.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import SwiftUI

struct DiscTrackList: View {
  
  let discNumber: Int
  let discTracks: [Track]
  let showDiscNumber: Bool
  let sourceArtist: String
  
  var body: some View {
    VStack(alignment: .leading) {
      if showDiscNumber {
        Text("Disc \(discNumber)")
          .fontWeight(.bold)
      }
      ForEach(discTracks) { track in
        TrackDetail(trackNumber: track.number,
                    trackArtist: track.artistName,
                    trackName: track.title,
                    trackDuration: track.duration,
                    sourceArtist: sourceArtist)
        }
        
    }
  }
}
