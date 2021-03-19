//
//  Reducer.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation

func updateState(state: AppState, action: StateAction) -> AppState {
  var state = state
  state.search = updateSearchState(searchState: state.search, action: action)
  return state
}
