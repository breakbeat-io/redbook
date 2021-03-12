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
      SourceCover(sourceName: viewModel.sourceName,
                 sourceArtist: viewModel.sourceArtist,
                 sourceArtworkURL: viewModel.sourceArtworkURL)
        .padding(.bottom)
      if showPlaybackLink {
        viewModel.sourcePlaybackURL.map { url in
          PlaybackLink(playbackURL: url)
            .padding(.bottom)
        }
      }
      TrackList(sourceTracks: viewModel.sourceTracks,
                sourceArtist: viewModel.sourceArtist)
    }
    .padding()
    .onAppear() {
      viewModel.loadSource(sourceId: sourceId)
    }
  }
}
