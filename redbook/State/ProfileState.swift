//
//  ProfileState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import Foundation
import os

struct ProfileState {
  var name: String
  var curator: String
}

extension ProfileState: Persistable {
  
  static func load(load: @escaping (ProfileState) -> Void) {
    Logger.state.log("🔊 Attempting to load a saved Profile state")
    
    Logger.state.log("🔊 Asking Core Data for a saved Profile state")
    PersistentProfile.fetchProfile("primary") { persistantProfile in
      if let profile = persistantProfile?.toState() {
        Logger.state.log("🔊 Got a saved Profile state from Core Data, loading")
        load(profile)
      } else {
        Logger.state.log("🔊 No saved Profile state from Core Data, checking CloudKit for unsynced records")
        PersistentProfile.checkCloudKitForRecord(named: "primary") { recordPresent in
          if recordPresent {
            Logger.state.log("🔊 There IS a saved profile on CloudKit, we can wait for it to sync")
          } else {
            Logger.state.log("🔊 There IS NOT a saved profile on CloudKit, we can create a new one")
            load(ProfileState(name: "primary", curator: "Music Lover"))
          }
        }
      }
    }
    
  }
  
  func save() {
    Logger.state.log("🔊 Attempting save of Profile state")
    let profiles = PersistentProfile.fetchAll()
    
    let profile = profiles.first ?? PersistentProfile(context: PersistenceController.shared.container.viewContext)
    
    profile.setValue(name, forKey: "name")
    profile.setValue(curator, forKey: "curator")
    
    PersistenceController.shared.save()
    Logger.state.log("🔊 Successfully saved Profile state")
    
  }
  
}
