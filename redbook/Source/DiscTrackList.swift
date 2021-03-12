//
//  DiscTrackList.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import SwiftUI
import HMV

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
        track.attributes.map { attributes in
          TrackDetail(trackNumber: attributes.trackNumber,
                      trackArtist: attributes.artistName,
                      trackName: attributes.name,
                      trackDuration: attributes.duration ?? "--:--",
                      sourceArtist: sourceArtist)
        }
        
      }
    }
  }
}
