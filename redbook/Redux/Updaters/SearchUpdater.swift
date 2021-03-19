//
//  UserReducer.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 17/03/2021.
//

import Foundation

func updateSearchState(searchState: SearchState, action: StateAction) -> SearchState {
  var searchState = searchState
  
  switch action {
  
  case let status as SearchAction.UpdateSearchStatus:
    if status.newStatus == .error || status.newStatus == .noResults {
      searchState.searchResults.removeAll()
    }
    searchState.searchStatus = status.newStatus
  
  case let update as SearchAction.UpdateResults:
    searchState.searchStatus = .idle
    searchState.searchResults = update.searchResults
  
  case _ as SearchAction.ClearResults:
    searchState.searchResults.removeAll()
    
  case let error as SearchAction.SearchError:
    searchState.searchStatus = .idle
    searchState.searchError = error.error
  
  default:
    break
  }
  
  return searchState
}
