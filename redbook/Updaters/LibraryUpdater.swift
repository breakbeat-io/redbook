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
  
  case let update as LibraryAction.CoreDataUpdate<PersistentCollection>:
    ()
//    var collections = [Collection]()
//    for cdCollection in update.cdCollections {
//      let collection: Collection = cdCollection.toCollection()
//      collections.append(collection)
//    }
//    // prob need to do some more checking here on the new Collections
//    if let newOnRotation = collections.first(where: { $0.type == .onRotation }) {
//      libraryState.onRotation = newOnRotation
//    }
//    libraryState.collections = collections.filter({ $0.type != .onRotation})
  
  case let update as LibraryAction.CoreDataUpdate<PersistentSource>:
    ()
    
  case let update as LibraryAction.CoreDataUpdate<PersistentSlot>:
    ()
    
  case let update as LibraryAction.AddSourceToSlot:
    libraryState.onRotation.slots[update.slotPosition].source = update.source
    
  case let update as LibraryAction.RemoveSourceFromSlot:
    libraryState.onRotation.slots[update.slotPosition].source = nil
  
  default:
    break
  }
  
  return libraryState
}
