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
  var curator: String = "Music Lover"
}

extension ProfileState: Persistable {
  
  var viewContext: NSManagedObjectContext { return PersistenceController.shared.container.viewContext }
  var profileFetchRequest: NSFetchRequest<NSFetchRequestResult> { return PersistentProfile.fetchRequest() }
  
  func load() -> ProfileState {
    persistenceLogger.log("🔊 Restoring saved state")
    
    var profile: ProfileState
    
    do {
      let fetchedProfiles = try viewContext.fetch(profileFetchRequest) as! [PersistentProfile]
      
      if fetchedProfiles.isEmpty {
        persistenceLogger.log("🔊 No saved Profile state, creating a new one")
        // TODO: I already exist, so not surw why i need to create a new one
        profile = ProfileState()
        self.save()
      } else {
        persistenceLogger.log("🔊 Found a Profile state, loading")
        let persistedProfile = fetchedProfiles.first
        profile = ProfileState(curator: persistedProfile!.curator!)
      }
      
    } catch {
        fatalError("Failed to fetch employees: \(error)")
    }
    
    return profile
    
  }
  
  func save() {
    persistenceLogger.log("🔊 Persisting Profile")
    
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
