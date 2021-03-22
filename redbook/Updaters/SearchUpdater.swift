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
  
  case let update as SearchAction.UpdateSearchStatus:
    if update.newStatus == .error || update.newStatus == .noResults {
      searchState.searchResults.removeAll()
    }
    searchState.searchStatus = update.newStatus
  
  case let update as SearchAction.UpdateResults:
    searchState.searchStatus = .idle
    searchState.searchResults = update.searchResults
  
  case _ as SearchAction.ClearResults:
    searchState.searchResults.removeAll()
    
  case let error as SearchAction.SearchError:
    searchState.searchStatus = .error
    searchState.searchError = error.error
  
  default:
    break
  }
  
  return searchState
}
