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
      var state = state
      
      switch self {
      
      case let update as CoreDataUpdate<PersistentProfile>:
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
