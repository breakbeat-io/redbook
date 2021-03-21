//
//  Track+Extensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 15/03/2021.
//

import Foundation

extension CDTrack {
  
  var trackNumber: Int {
    Int(number)
  }
  
  var trackSegment: Int {
    Int(segment)
  }
  
  var trackTitle: String {
    title ?? "[title missing]"
  }
  
  var trackArtistName: String {
    artistName ?? "[artist missing]"
  }
  
  var trackDuration: String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .positional

    return formatter.string(from: TimeInterval(duration/1000)) ?? "--:--"
  }
  
}
