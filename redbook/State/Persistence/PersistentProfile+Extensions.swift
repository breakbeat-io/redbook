//
//  PersistentProfile+Extensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import Foundation
import os

extension PersistentProfile {
  
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
    return ProfileState(curator: curator!)
  }
  
}
