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
  
  case let update as LibraryAction.CoreDataUpdate<CDCollection>:
    print("🔊 Collection Update In Process for \(update.entities.count) \(type(of: update.entities))'s")
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
  
  case let update as LibraryAction.CoreDataUpdate<CDSlot>:
    print("🔊 Slot Update In Process for \(update.entities.count) \(type(of: update.entities))'s")
    
  case let update as LibraryAction.CoreDataUpdate<CDSource>:
    print("🔊 Source Update In Process for \(update.entities.count) \(type(of: update.entities))'s")
    
  case let update as LibraryAction.AddSourceToSlot:
    print("🔊 Adding source to slot \(update.slotPosition) for reealz")
    libraryState.onRotation.slots[update.slotPosition].source = update.source
    
  case let update as LibraryAction.RemoveSourceFromSlot:
    print("🔊 Removing source from slot \(update.slotPosition)")
    libraryState.onRotation.slots[update.slotPosition].source = nil
  
  default:
    break
  }
  
  return libraryState
}
