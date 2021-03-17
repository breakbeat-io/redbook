//
//  AppState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

struct AppState {
  var search: SearchState = SearchState()
}

struct SearchState {
  var searchResults: [Source] = []
}
