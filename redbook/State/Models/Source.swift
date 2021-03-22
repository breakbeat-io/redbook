//
//  Source.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 21/03/2021.
//

import Foundation

struct Source: Identifiable {
  let id = UUID()
  let providerId: String
  let title: String
  let artistName: String
  let artworkURL: URL
  let playbackURL: URL
  var tracks: [Track]
}
