//
//  SearchState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 21/03/2021.
//

struct SearchState {
  var searchStatus: SearchStatus = .idle
  var searchResults: [Source] = []
  var searchError: Error?
  
  enum SearchStatus: String {
    case idle = ""
    case searching = "Searching"
    case noResults = "There were no results, please try again."
    case error = "There was an error, please try again."
  }
  
}
