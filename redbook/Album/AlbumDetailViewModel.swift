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
