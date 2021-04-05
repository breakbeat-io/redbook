//
//  CoreDataActions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 05/04/2021.
//

import Foundation
import CoreData

struct CoreDataAction {
  
  struct Update<T: NSManagedObject>: StateAction {
    let entities: [T]
    
    func updateState(_ state: AppState) -> AppState {
      var state = state
      
      switch self {
      
      case let update as Update<PersistentProfile>:
        state.profile = update.entities.first!.toState()
        
      default:
        break
      
      }
      return state
    }
    
    func logMessage() -> String {
      return "🔊 Performing a Core Data update for \(entities.count) \(type(of: entities).Element.self)'s"
    }
  }
  
  
}
