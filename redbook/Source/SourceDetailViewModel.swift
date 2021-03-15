//
//  SourceDetailViewModel.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/03/2021.
//

import Foundation
import os.log
import struct HMV.Track

extension SourceDetail {
  
  class ViewModel: ObservableObject {
    
    @Published private(set) var source: Source?
    @Published private(set) var tracks: [Int:[HMV.Track]]?
    
    func loadSource(sourceId: String) {
      
      RecordStore.appleMusic.album(id: sourceId, completion: { appleMusicAlbum, error in
        if let appleMusicAlbum = appleMusicAlbum {
          DispatchQueue.main.async {
            self.source = appleMusicAlbum.toSource()
            self.tracks = appleMusicAlbum.tracks()
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
