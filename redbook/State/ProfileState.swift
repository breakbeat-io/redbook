//
//  ProfileState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import Foundation
import os

struct ProfileState {
  var curator: String
}

extension ProfileState: Persistable {
  
  static func load() -> ProfileState {
    Logger.persistence.log("🔊 Restoring saved Profile state")
    
    var profileState: ProfileState
    let profiles = PersistentProfile.fetchAll()
    
    if profiles.isEmpty {
      Logger.persistence.log("🔊 No saved Profile state, creating a new one")
      profileState = ProfileState(curator: "Music Lover")
      profileState.save()
    } else {
      Logger.persistence.log("🔊 Found a Profile state, loading")
      let persistedProfile = profiles.first!
      profileState = persistedProfile.toState()
    }
    
    return profileState
    
  }
  
  func save() {
    Logger.persistence.log("🔊 Attempting save of Profile state")
    let profiles = PersistentProfile.fetchAll()
    
    let profile = profiles.first ?? PersistentProfile(context: PersistenceController.shared.container.viewContext)
    
    profile.setValue(curator, forKey: "curator")
    
    PersistenceController.shared.save()
    Logger.persistence.log("🔊 Successfully saved Profile state")
    
  }
  
}
