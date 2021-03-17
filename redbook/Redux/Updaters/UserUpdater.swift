//
//  UserReducer.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 17/03/2021.
//

import Foundation

func updateUserState(userState: UserState, action: StateAction) -> UserState {
  var userState = userState
  
  switch action {
  
  case _ as UserAction.ChangeCurator:
    userState.curatorName = ["alan", "john", "peter"].randomElement() ?? ""
    
  case _ as UserAction.ChangeLabel:
    userState.labelName = ["metalheadz", "moving shadow", "sub base"].randomElement() ?? ""
  
  default:
    break
  }
  
  return userState
}
