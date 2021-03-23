//
//  SourceDetail.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import os.log
import SwiftUI

struct SourceDetail: View {
  
  @State var source: Source?
  var sourceId: String
  var showPlaybackLink: Bool
  
  var body: some View {
    
    ScrollView {
      if let source = source {
        SourceCover(sourceName: source.title,
                    sourceArtist: source.artistName,
                    sourceArtworkURL: source.artworkURL)
          .padding(.bottom)
        
        if showPlaybackLink {
          PlaybackLink(playbackURL: source.playbackURL)
              .padding(.bottom)
        }
//        viewModel.tracks.map { tracks in
//          TrackList(sourceTracks: tracks,
//                    sourceArtist: source.artistName)
//        }
      }
    }
    .padding()
    .onAppear() {
      RecordStore.appleMusic.album(id: sourceId) { appleMusicAlbum, error in
        if let appleMusicAlbum = appleMusicAlbum {
          DispatchQueue.main.async {
            self.source = appleMusicAlbum.toSource()
//            self.tracks = appleMusicAlbum.toTracks()
          }
        }
        
        if let error = error {
          os_log("💎 Load Album error: %s", String(describing: error))
          // TODO: create another action to show an error in album add.
        }
      }
    }
  }
}
