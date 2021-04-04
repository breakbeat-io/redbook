//
//  AppState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

struct AppState {
  var active = ActiveState()
  var profile = ProfileState()
  var library: LibraryState
  var search = SearchState()
  
  static var initial: AppState {
    AppState(library: LibraryState(onRotation: Collection.emptyOnRotation))
  }

}
