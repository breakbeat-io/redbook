//
//  ProfileState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import Foundation
import os
import CoreData

struct ProfileState {
  var curator: String
}

extension ProfileState: Persistable {
  
  static func load() -> ProfileState {
    Logger.persistence.log("🔊 Restoring saved Profile state")
    
    var profileState: ProfileState
    
    do {
      let fetchedProfiles = try PersistenceController.shared.container.viewContext.fetch(PersistentProfile.fetchRequest()) as! [PersistentProfile]
      
      if fetchedProfiles.isEmpty {
        Logger.persistence.log("🔊 No saved Profile state, creating a new one")
        profileState = ProfileState(curator: "Music Lover")
        profileState.save()
      } else {
        Logger.persistence.log("🔊 Found a Profile state, loading")
        let persistedProfile = fetchedProfiles.first!
        profileState = persistedProfile.toState()
      }
      
    } catch {
      fatalError("Failed to fetch Profile state: \(error)")
    }
    
    return profileState
    
  }
  
  func save() {
    Logger.persistence.log("🔊 Attempting save of Profile state")
    
    do {
      let fetchedProfiles = try PersistenceController.shared.container.viewContext.fetch(PersistentProfile.fetchRequest()) as! [PersistentProfile]
      
      let profile = fetchedProfiles.first ?? PersistentProfile(context: PersistenceController.shared.container.viewContext)
      
      profile.setValue(curator, forKey: "curator")

      PersistenceController.shared.save()
      Logger.persistence.log("🔊 Successfully saved Profile state")
    } catch {
      fatalError("Failed to fetch Profile state: \(error)")
    }
  }
  
}
