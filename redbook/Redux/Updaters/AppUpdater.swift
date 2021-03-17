//
//  Reducer.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation

func updateState(state: AppState, action: StateAction) -> AppState {
  var state = state
  state.user = updateUserState(userState: state.user, action: action)
  return state
}
