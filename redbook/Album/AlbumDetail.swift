//
//  AlbumDetail.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import os.log
import SwiftUI
import HMV

struct AlbumDetail: View {
  
  @StateObject var viewModel = ViewModel()
  var albumId: String
  var showPlaybackLink: Bool
  
  var body: some View {
    ScrollView {
      AlbumCover(albumName: viewModel.albumName,
                 albumArtist: viewModel.albumArtist,
                 albumArtwork: viewModel.albumArtwork)
        .padding(.bottom)
      if showPlaybackLink {
        viewModel.albumPlaybackURL.map { url in
          PlaybackLink(playbackURL: url)
            .padding(.bottom)
        }
      }
      TrackList(albumTracks: viewModel.albumTracks,
                albumArtist: viewModel.albumArtist)
    }
    .padding()
    .onAppear() {
      viewModel.loadAlbum(albumId: albumId)
    }
  }
}
