//
//  PersistentProfile+Extensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import Foundation
import os
import CoreData

extension PersistentProfile {
  
  static func fetchProfile(_ name: String, completion: (PersistentProfile?) -> Void) {
    Logger.coredata.log("🔊 Attempting to find a Profile named `\(name)`")
    
    var profiles: [PersistentProfile] = []
    
    do {
      let profileFetchRequest: NSFetchRequest<PersistentProfile> = PersistentProfile.fetchRequest()
      profileFetchRequest.predicate = NSPredicate(format: "name == %@", name)
      profiles = try PersistenceController.shared.container.viewContext.fetch(profileFetchRequest)
    } catch {
      fatalError()
    }
    
    switch profiles.count {
    
    case 0:
      Logger.coredata.log("🔊 No Profiles named `\(name)` found")
      completion(nil)
      
    case 1:
      Logger.coredata.log("🔊 Single Profile named `\(name)` found")
      completion(profiles.first)
      
    case 1...Int.max:
      Logger.coredata.log("🔊 Multiple Profiles named `\(name)` found")
      // TODO: here we should now tidy up the extra profiles
      completion(profiles.first)
      
    default:
      completion(nil)
      
    }
    
  }
  
  static func checkCloudKitForRecord(named name: String, completion: @escaping (Bool) -> Void) {
    Logger.cloudkit.log("🔊 Attempting to find a CloudKit \(String(describing: self)) record named `\(name)`")
    
    // TODO: not sure if hardcoding the ID is wise, but otherwise it defaulst to the Info.plist which is suffixed depending on build.
    let ckContainer = CKContainer(identifier: "iCloud.io.breakbeat.redbook")
    let privateDatabase = ckContainer.privateCloudDatabase
    let predicate = NSPredicate(format: "CD_name == %@", name)
    let query = CKQuery(recordType: "CD_PersistentProfile", predicate: predicate)
    
    privateDatabase.perform(query, inZoneWith: nil) { results, error in
      
      if (error != nil) {
        Logger.cloudkit.log("🔊 There was an error querying CloudKit \(error.debugDescription)")
        // TODO: needs to determine what to do when there is an error - attempt to resolve or create a new default profile.
        completion(false)
      } else {
        switch results!.count {
        
        case 0:
          Logger.cloudkit.log("🔊 There were no matching records found")
          completion(false)
          
        case 1:
          Logger.cloudkit.log("🔊 There was one matching record found")
          completion(true)
          
        case 1...Int.max:
          Logger.cloudkit.log("🔊 There were many matching records found")
          // TODO: here we should now tidy up the extra records
          completion(true)
          
        default:
          Logger.cloudkit.log("🔊 Somehow we got a non-Int as a count on an Array")
          completion(false)
          
        }
      }
    }
  }
  

  
  static func fetchAll() -> [PersistentProfile] {
    var profiles: [PersistentProfile] = []
    
    do {
      profiles = try PersistenceController.shared.container.viewContext.fetch(PersistentProfile.fetchRequest()) as! [PersistentProfile]
    } catch {
      fatalError("Failed to fetch Profiles: \(error)")
    }
    
    return profiles
  }
  
  func toState() -> ProfileState {
    return ProfileState(name: name!, curator: curator!)
  }
  
}
