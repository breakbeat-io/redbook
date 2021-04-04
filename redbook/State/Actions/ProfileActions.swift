//
//  ProfileActions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import Foundation

struct ProfileAction {
  
  struct UpdateCurator: StateAction {
    let curator: String
    
    func updateState(_ state: AppState) -> AppState {
      var state = state
      state.profile.curator = curator
      return state
    }
    
    func logMessage() -> String {
      "🔊 Updating curator to \(curator)"
    }
  }
  
  struct Save: StateAction {
    func updateState(_ state: AppState) -> AppState {
      state.profile.save()
      return state
    }
    
    func logMessage() -> String {
      "🔊 Requesting save of Profile state"
    }
  }
  
}
