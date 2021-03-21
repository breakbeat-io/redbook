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
    return Source(
      providerId: id,
      title: attributes?.name ?? "Unknown Title",
      artistName: attributes?.artistName ?? "Unknown Artist",
      artworkURL: attributes?.artwork.url(forWidth: 1000) ?? URL(string: "http://www.google.com")!,
      playbackURL: attributes?.url ?? URL(string: "about:blank")!
    )
  }
  
  func toTracks() -> [Int:[CDTrack]] {
    
    var sourceTracks = [Int:[CDTrack]]()
    let appleMusicAlbumTracks = relationships?.tracks.data ?? [HMV.Track]()
    let numberOfDiscs = appleMusicAlbumTracks.map { $0.attributes?.discNumber ?? 1 }.max() ?? 1
    
    for i in 1...numberOfDiscs {
      
      let appleMusicAlbumDiscTracks = appleMusicAlbumTracks.filter { $0.attributes?.discNumber == i }
      var sourceSegmentTracks = [CDTrack]()
      
      for sourceTrack in appleMusicAlbumDiscTracks {
        
        let track = CDTrack(entity: CDTrack.entity(), insertInto: nil)
        track.providerId = sourceTrack.id
        track.title = sourceTrack.attributes?.name
        track.artistName = sourceTrack.attributes?.artistName
        track.number = Int16(sourceTrack.attributes?.trackNumber ?? 0)
        track.segment = Int16(sourceTrack.attributes?.discNumber ?? 0)
        track.duration = Int32(sourceTrack.attributes?.durationInMillis ?? 0)
        sourceSegmentTracks.append(track)
        
      }
      
      sourceTracks[i] = sourceSegmentTracks
    }
    
    return sourceTracks
  }
  
}
