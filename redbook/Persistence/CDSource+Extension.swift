//
//  Source+OptionalHelpers.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 14/03/2021.
//

import Foundation

extension CDSource {
  
  var sourceProviderId: String {
    providerId ?? ""
  }
  
  var sourceName: String {
    title ?? "[name missing]"
  }
  
  var sourceArtist: String {
    artistName ?? "[artist missing]"
  }
  
  var sourceArtworkURL: URL {
    artworkURL ?? URL(string: "https://via.placeholder.com/1000?text=+")!
  }
  
}
