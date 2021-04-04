//
//  AppState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import os

protocol Persistable {
  func load() -> Self
  func save() // could prob do a genrics thing here?
}

extension Persistable {
  var persistenceLogger: Logger {
    get { return Logger(subsystem: "io.breakbeat.redbook", category: "persitence") }
  }
}

struct AppState {
  var active = ActiveState()
  var profile = ProfileState() {
    didSet {
      profile.save()
    }
  }
  var library = LibraryState(onRotation: Collection.emptyOnRotation)
  var search = SearchState()
  
  init() {
    profile = profile.load()
  }

}
