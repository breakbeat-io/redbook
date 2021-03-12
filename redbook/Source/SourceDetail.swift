//
//  SourceDetail.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import os.log
import SwiftUI
import HMV

struct SourceDetail: View {
  
  @StateObject var viewModel = ViewModel()
  var sourceId: String
  var showPlaybackLink: Bool
  
  var body: some View {
    ScrollView {
      SourceCover(sourceName: viewModel.albumName,
                 sourceArtist: viewModel.albumArtist,
                 sourceArtwork: viewModel.albumArtwork)
        .padding(.bottom)
      if showPlaybackLink {
        viewModel.albumPlaybackURL.map { url in
          PlaybackLink(playbackURL: url)
            .padding(.bottom)
        }
      }
      TrackList(sourceTracks: viewModel.albumTracks,
                sourceArtist: viewModel.albumArtist)
    }
    .padding()
    .onAppear() {
      viewModel.loadSource(sourceId: sourceId)
    }
  }
}
