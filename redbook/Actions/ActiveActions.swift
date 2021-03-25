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
    
    func logMessage() -> String {
      "🔊 Loading \(source.title)"
    }
  }
  
  struct UnloadSource: StateAction {
    
    func logMessage() -> String {
      "🔊 Unloading active Source"
    }
  }
  
  struct UpdateLoadStatus: StateAction {
    let newStatus: ActiveState.LoadStatus
    
    func logMessage() -> String {
      "🔊 Setting load status to \(newStatus)"
    }
  }
  
  struct LoadError: StateAction {
    let error: Error
    
    func logMessage() -> String {
      "🔊 Search error: \(error.localizedDescription)"
    }
  }
  
}
