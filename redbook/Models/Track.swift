//
//  Track.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 21/03/2021.
//

import Foundation

struct Track {
  let id = UUID()
  let providerId: String
  let title: String
  let artistName: String
  let number: Int
  let segment: Int
}
