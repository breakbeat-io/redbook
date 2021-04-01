//
//  ActiveActions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 23/03/2021.
//

import Foundation

struct ActiveAction {
  
  struct LoadSource: StateAction {
    let source: Source
    
    func updateState(_ state: AppState) -> AppState {
      var state = state
      state.active.source = source
      state.active.loadStatus = .idle
      return state
    }
    
    func logMessage() -> String {
      "🔊 Loading \(source.title)"
    }
  }
  
  struct UnloadSource: StateAction {
    
    func updateState(_ state: AppState) -> AppState {
      var state = state
      state.active.source = nil
      state.active.loadStatus = .idle
      return state
    }
    
    func logMessage() -> String {
      "🔊 Unloading active Source"
    }
  }
  
  struct UpdateLoadStatus: StateAction {
    let newStatus: ActiveState.LoadStatus
    
    func updateState(_ state: AppState) -> AppState {
      var state = state
      state.active.loadStatus = newStatus
      return state
    }
    
    func logMessage() -> String {
      "🔊 Setting load status to \(newStatus)"
    }
  }
  
  struct LoadError: StateAction {
    let error: Error
    
    func updateState(_ state: AppState) -> AppState {
      var state = state
      state.active.loadStatus = .error
      state.active.loadError = error
      return state
    }
    
    func logMessage() -> String {
      "🔊 Search error: \(error.localizedDescription)"
    }
  }
  
}
