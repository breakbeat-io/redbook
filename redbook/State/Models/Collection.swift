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
  var slots: [Slot] = (1...8).map { position in Slot(position: position) }
  var name: String
  var curator: String
  
  static var emptyOnRotation: Collection {
    Collection(
      type: .onRotation,
      name: CollectionType.onRotation.rawValue,
      curator: "A Music Lover"
    )
  }
  
  enum CollectionType: String {
    case onRotation = "On Rotation"
    case user = "User"
    case shared = "Shared"
  }
}
