//
//  Collection.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 21/03/2021.
//

import Foundation

struct Collection {
  let id = UUID()
  let type: CollectionType
  var curator: String
  var name: String
  var slots: [Slot]
  
  enum CollectionType {
    case onRotation
    case user
    case shared
  }
}
