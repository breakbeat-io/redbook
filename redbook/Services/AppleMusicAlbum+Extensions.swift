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
    return Source(providerId: id,
                  title: attributes?.name ?? "Unknown Title",
                  artistName: attributes?.artistName ?? "Unknown Artist",
                  artworkURL: attributes?.artwork.url(forWidth: 1000) ?? URL(string: "http://www.google.com")!,
                  playbackURL: attributes?.url ?? URL(string: "about:blank")!,
                  tracks: toTracks()
    )
  }
  
  func toTracks() -> [Int:[Track]] {
    var sourceTracks = [Int:[Track]]()
    let appleMusicAlbumTracks = relationships?.tracks.data ?? [HMV.Track]()
    let numberOfParts = appleMusicAlbumTracks.map { $0.attributes?.discNumber ?? 1 }.max() ?? 1
    
    for i in 1...numberOfParts {
      
      let appleMusicAlbumDiscTracks = appleMusicAlbumTracks.filter { $0.attributes?.discNumber == i }
      var sourcePartTracks = [Track]()
      
      for sourceTrack in appleMusicAlbumDiscTracks {
        
        let track = Track(providerId: sourceTrack.id,
                          title: sourceTrack.attributes?.name ?? "Unknown Title",
                          artistName: sourceTrack.attributes?.artistName ?? "Unknown Artist",
                          duration: sourceTrack.attributes?.duration ?? "--:--",
                          number: sourceTrack.attributes?.trackNumber ?? 0,
                          part: sourceTrack.attributes?.discNumber ?? 0
        )
        
        sourcePartTracks.append(track)
        
      }
      
      sourceTracks[i] = sourcePartTracks
    }
    
    return sourceTracks
  }
  
}
