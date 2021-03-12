//
//  SourceDetailViewModel.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import Foundation
import os.log
import HMV

extension SourceDetail {
  
  class ViewModel: ObservableObject {
    
    @Published private(set) var source: Album?
    
    var albumName: String {
      source?.attributes?.name ?? ""
    }
    var albumArtist: String {
      source?.attributes?.artistName ?? ""
    }
    var albumArtwork: URL {
      // TODO: Using the third party placeholder image is dangerous
      source?.attributes?.artwork.url(forWidth: 1000) ?? URL(string: "https://via.placeholder.com/1000x1000?text=Getting+artwork...")!
    }
    var albumTracks: [Int:[Track]] {
      let allTracks = source?.relationships?.tracks.data ?? [Track]()
      let numberOfDiscs = allTracks.map { $0.attributes?.discNumber ?? 1 }.max() ?? 1
      var albumTracks = [Int: [Track]]()
      for i in 1...numberOfDiscs {
        albumTracks[i] = allTracks.filter { $0.attributes?.discNumber == i }
      }
      return albumTracks
    }
    var albumPlaybackURL: URL? {
      source?.attributes?.url
    }
    
    
    // TODO: loading states to show spinners
    
    
    func loadSource(sourceId: String) {
      RecordStore.appleMusic.album(id: sourceId, completion: { album, error in
        if let album = album {
          //convert album to source
          
          DispatchQueue.main.async {
            self.source = album
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
