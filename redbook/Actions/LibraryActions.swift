//
//  LibraryActions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 21/03/2021.
//

import Foundation
import CoreData
import Combine

struct LibraryAction {
  
  struct CoreDataUpdate<T: NSManagedObject>: StateAction {
    let entities: [T]
    
    func logMessage() -> String {
      return "🔊 Performing a Core Data update for \(entities.count) \(type(of: entities).Element.self)'s"
    }
  }
  
  struct AddSourceToSlot: StateAction {
    let source: Source
    let slotPosition: Int
    
    func logMessage() -> String {
      "🔊 Adding \(source.title) to slot \(slotPosition)"
    }
  }
  
  struct RemoveSourceFromSlot: StateAction {
    let slotPosition: Int
    
    func logMessage() -> String {
      "🔊 Removing source from slot \(slotPosition)"
    }
  }
  
  struct LoadSource: StateAction {
    let source: Source
    
    func logMessage() -> String {
      "🔊 Loading \(source.title)"
    }
  }
  
  struct UnloadSource: StateAction {
    
    func logMessage() -> String {
      "🔊 Unloading active Source"
    }
  }
  
}
