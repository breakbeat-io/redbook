//
//  ActiveUpdater.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 23/03/2021.
//

import Foundation

func updateActiveState(activeState: ActiveState, action: StateAction) -> ActiveState {
  var activeState = activeState
  
  switch action {
  
  case let update as ActiveAction.LoadSource:
    activeState.source = update.source
    activeState.loadStatus = .idle
    
  case _ as ActiveAction.UnloadSource:
    activeState.source = nil
    activeState.loadStatus = .idle
    
  case let update as ActiveAction.UpdateLoadStatus:
    activeState.loadStatus = update.newStatus
    
  case let error as ActiveAction.LoadError:
    activeState.loadStatus = .error
    activeState.loadError = error.error
  
  default:
    break
  }
  
  return activeState
}
