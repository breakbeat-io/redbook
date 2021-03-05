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
  let albumArtist: String
  
  var body: some View {
    VStack(alignment: .leading) {
      if showDiscNumber {
        Text("Disc \(discNumber)")
          .fontWeight(.bold)
      }
      ForEach(discTracks) { track in
        if track.attributes != nil {
          // TODO: get rid of forced unwraps
          TrackDetail(trackNumber: track.attributes!.trackNumber,
                      trackArtist: track.attributes!.artistName,
                      trackName: track.attributes!.name,
                      trackDuration: track.attributes!.duration!,
                      albumArtist: albumArtist)
        }
        
      }
    }
  }
}
