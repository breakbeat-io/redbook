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
    
  case _ as ActiveAction.UnloadSource:
    activeState.source = nil
  
  default:
    break
  }
  
  return activeState
}
