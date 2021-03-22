//
//  SourceDetail.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import os.log
import SwiftUI

struct SourceDetail: View {
  
  @StateObject var viewModel = ViewModel()
  var sourceId: String
  var showPlaybackLink: Bool
  
  var body: some View {
    
    ScrollView {
      if let source = viewModel.source {
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
      viewModel.loadSource(sourceId: sourceId)
    }
  }
}
