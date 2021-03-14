//
//  Source+OptionalHelpers.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 14/03/2021.
//

import Foundation

extension Source {
  
  var sourceProviderId: String {
    providerId ?? ""
  }
  
  var sourceName: String {
    name ?? "[name missing]"
  }
  
  var sourceArtist: String {
    artist ?? "[artist missing]"
  }
  
  var sourceArtworkURL: URL {
    artworkURL ?? URL(string: "https://via.placeholder.com/1000?text=+")!
  }
  
}
