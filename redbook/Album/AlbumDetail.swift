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
  
  @StateObject var viewModel: ViewModel
  var albumId: String
  
  var body: some View {
    ScrollView {
      // TODO: all of these optionals should move into the viewModel
      AlbumCover(albumName: viewModel.album?.attributes?.name ?? "",
                 albumArtist: viewModel.album?.attributes?.artistName ?? "",
                 albumArtwork: viewModel.album?.attributes?.artwork.url(forWidth: 1000) ?? URL(string: "https://picsum.photos/500/500")!)
        .padding(.bottom)
      TrackList(albumTracks: viewModel.album?.relationships?.tracks.data ?? [Track](), albumArtist: viewModel.album?.attributes?.artistName ?? "")
    }
    .padding()
    .onAppear() {
      viewModel.loadAlbum(albumId: albumId)
    }
  }
}
