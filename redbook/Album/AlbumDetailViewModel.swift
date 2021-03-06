//
//  AlbumDetailViewModel.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import Foundation
import os.log
import HMV

extension AlbumDetail {
  
  class ViewModel: ObservableObject {
    
    @Published private(set) var album: Album?
    
    var albumName: String {
      album?.attributes?.name ?? ""
    }
    var albumArtist: String {
      album?.attributes?.artistName ?? ""
    }
    var albumArtwork: URL {
      album?.attributes?.artwork.url(forWidth: 1000) ?? URL(string: "https://via.placeholder.com/1000x1000?text=Getting+artwork...")!
    }
    var albumTracks: [Int:[Track]] {
      let allTracks = album?.relationships?.tracks.data ?? [Track]()
      let numberOfDiscs = allTracks.map { $0.attributes?.discNumber ?? 1 }.max() ?? 1
      var albumTracks = [Int: [Track]]()
      for i in 1...numberOfDiscs {
        albumTracks[i] = allTracks.filter { $0.attributes?.discNumber == i }
      }
      return albumTracks
    }
    
    
    // TODO: need to clear down when view unloads to prevent flahses of old values
    // TODO: loading states to show spinners
    
    func loadAlbum(albumId: String) {
      RecordStore.appleMusic.album(id: albumId, completion: { album, error in
        // TODO: double let (just copied old code)
        if let album = album {
          DispatchQueue.main.async {
            self.album = album
          }
        }
        
        if let error = error {
          os_log("💎 Load Album error: %s", String(describing: error))
          // TODO: create another action to show an error in album add.
        }
      })
    }
    
  }
}
