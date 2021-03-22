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
    
    func log() -> String {
      "🔊 Performing a Core Data Update"
    }
  }
  
  struct AddSourceToSlot: StateAction {
    let source: Source
    let slotPosition: Int
    
    func log() -> String {
      "🔊 Adding \(source) to \(slotPosition)"
    }
  }
  
  struct RemoveSourceFromSlot: StateAction {
    let slotPosition: Int
    
    func log() -> String {
      "🔊 Removing source from \(slotPosition)"
    }
  }
  
}
