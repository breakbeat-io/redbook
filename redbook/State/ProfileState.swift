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
    
    let viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    Logger.persistence.log("🔊 Restoring saved state")
    
    var profile: ProfileState
    
    do {
      let fetchedProfiles = try viewContext.fetch(PersistentProfile.fetchRequest()) as! [PersistentProfile]
      
      if fetchedProfiles.isEmpty {
        Logger.persistence.log("🔊 No saved Profile state, creating a new one")
        profile = ProfileState(curator: "Music Lover")
        profile.save()
      } else {
        Logger.persistence.log("🔊 Found a Profile state, loading")
        let persistedProfile = fetchedProfiles.first
        profile = ProfileState(curator: persistedProfile!.curator!)
      }
      
    } catch {
        fatalError("Failed to fetch employees: \(error)")
    }
    
    return profile
    
  }
  
  func save() {
    let viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    let profileFetchRequest: NSFetchRequest<NSFetchRequestResult> = PersistentProfile.fetchRequest()
    
    Logger.persistence.log("🔊 Persisting Profile")
    
    do {
      let fetchedProfiles = try viewContext.fetch(profileFetchRequest) as! [PersistentProfile]
      
      if fetchedProfiles.isEmpty {
        let profile = PersistentProfile(context: viewContext)
        profile.curator = curator
      } else {
        fetchedProfiles.first?.setValue(curator, forKey: "curator")
      }
      PersistenceController.shared.save()
      
    } catch {
        fatalError("Failed to fetch employees: \(error)")
    }
  }

}
