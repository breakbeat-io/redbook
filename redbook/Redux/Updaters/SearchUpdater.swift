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
  
  case let update as SearchAction.UpdateResults:
    searchState.searchResults = update.searchResults
  
  case _ as SearchAction.ClearResults:
    searchState.searchResults = []
  
  default:
    break
  }
  
  return searchState
}
