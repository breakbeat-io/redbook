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
  
  enum SearchStatus {
    case idle
    case searching
    case noResults
    case error
  }
  
}
