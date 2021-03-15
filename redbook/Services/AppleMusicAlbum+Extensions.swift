//
//  AppleMusicAlbum+Extensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 15/03/2021.
//

import Foundation
import struct HMV.Album
import struct HMV.Track

typealias AppleMusicAlbum = Album

extension AppleMusicAlbum {
  func toSource() -> Source {
    let source = Source(entity: Source.entity(), insertInto: nil)
    source.providerId = id
    source.title = attributes?.name
    source.artistName = attributes?.artistName
    source.artworkURL = attributes?.artwork.url(forWidth: 1000)
    source.playbackURL = attributes?.url
    
    return source
  }
  
  func tracks() -> [Int:[HMV.Track]] {
    var sourceTracks = [Int:[HMV.Track]]()
    let allTracks = relationships?.tracks.data ?? [HMV.Track]()
    let numberOfDiscs = allTracks.map { $0.attributes?.discNumber ?? 1 }.max() ?? 1
    for i in 1...numberOfDiscs {
      sourceTracks[i] = allTracks.filter { $0.attributes?.discNumber == i }
    }
    return sourceTracks
  }
  
}
