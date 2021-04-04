//
//  AppState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import os

protocol Persistable {
  static func load() -> Self
  func save()
}

struct AppState {
  var active = ActiveState()
  var profile: ProfileState
  var library = LibraryState(onRotation: Collection.emptyOnRotation)
  var search = SearchState()

}
