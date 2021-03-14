//
//  RecordStore.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/03/2021.
//

import Foundation
import os.log
import HMV

struct RecordStore {
  
  static let appleMusic = HMV(storefront: .unitedKingdom, developerToken: Bundle.main.infoDictionary?["APPLE_MUSIC_API_TOKEN"] as! String)
  
  private init() { }
  
}

typealias AppleMusicAlbum = Album

extension AppleMusicAlbum {
  func toSource() -> Source {
    let source = Source(entity: Source.entity(), insertInto: nil)
    source.providerId = id
    source.name = attributes?.name
    source.artist = attributes?.artistName
    source.artworkURL = attributes?.artwork.url(forWidth: 1000)
    source.playbackURL = attributes?.url
    
    return source
  }
}
