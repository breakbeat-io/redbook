//
//  LibraryUpdater.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 21/03/2021.
//

import Foundation
import CoreData

func updateLibraryState(libraryState: LibraryState, action: StateAction) -> LibraryState {
  var libraryState = libraryState
  
  switch action {
  
  case _ as LibraryAction.CoreDataUpdate<PersistentCollection>:
    ()
  
  case _ as LibraryAction.CoreDataUpdate<PersistentSource>:
    ()
    
  case _ as LibraryAction.CoreDataUpdate<PersistentSlot>:
    ()
    
  case let update as LibraryAction.AddSourceToSlot:
    if let slotPosition = libraryState.onRotation.slots.firstIndex(where: { $0.position == update.slotPosition }) {
      libraryState.onRotation.slots[slotPosition].source = update.source
    }
    
  case let update as LibraryAction.RemoveSourceFromSlot:
    if let slotPosition = libraryState.onRotation.slots.firstIndex(where: { $0.position == update.slotPosition }) {
      libraryState.onRotation.slots[slotPosition].source = nil
    }
  
  default:
    break
  }
  
  return libraryState
}
