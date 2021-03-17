//
//  AppState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

struct AppState {
  var user: UserState
}

struct UserState {
  var curatorName: String = "Change Me"
  var labelName: String = "Will be changed"
}
