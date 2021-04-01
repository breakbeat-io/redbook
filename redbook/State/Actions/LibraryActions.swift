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
    
    func updateState(_ state: AppState) -> AppState {
      switch self {
      
      case _ as CoreDataUpdate<PersistentCollection>:
        // TODO: deal with the core data update
        break
        
      case _ as CoreDataUpdate<PersistentSource>:
        // TODO: deal with the core data update
        break
        
      case _ as CoreDataUpdate<PersistentSlot>:
        // TODO: deal with the core data update
        break
        
      default:
        break
      
      }
      return state
    }
    
    func logMessage() -> String {
      return "🔊 Performing a Core Data update for \(entities.count) \(type(of: entities).Element.self)'s"
    }
  }
  
  struct AddSourceToSlot: StateAction {
    let source: Source
    let slotPosition: Int
    
    func updateState(_ state: AppState) -> AppState {
      var state = state
      if let slotPosition = state.library.onRotation.slots.firstIndex(where: { $0.position == slotPosition }) {
        state.library.onRotation.slots[slotPosition].source = source
      }
      
      return state
    }
    
    func logMessage() -> String {
      "🔊 Adding \(source.title) to slot \(slotPosition)"
    }
  }
  
  struct RemoveSourceFromSlot: StateAction {
    let slotPosition: Int
    
    func updateState(_ state: AppState) -> AppState {
      var state = state
      if let slotPosition = state.library.onRotation.slots.firstIndex(where: { $0.position == slotPosition }) {
        state.library.onRotation.slots[slotPosition].source = nil
      }
      return state
    }
    
    func logMessage() -> String {
      "🔊 Removing source from slot \(slotPosition)"
    }
  }
  
}
