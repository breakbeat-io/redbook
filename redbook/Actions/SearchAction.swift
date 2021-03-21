//
//  SearchAction.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 17/03/2021.
//

import Foundation
import CoreData
import Combine

struct SearchAction {
  
  struct UpdateSearchStatus: StateAction {
    let newStatus: SearchState.SearchStatus
  }
  
  struct UpdateResults: StateAction {
    let searchResults: [CDSource]
  }
  
  struct ClearResults: StateAction { }
  
  struct SearchError: StateAction {
    let error: Error
  }
  
  struct AppleMusicSearch: FutureAction {
    let searchTerm: String
    
    func execute() -> AnyPublisher<StateAction, Never> {
      return Future() { promise in
        RecordStore.appleMusic.search(term: searchTerm, limit: 20, types: [.albums]) { results, error in
          var action: StateAction = SearchAction.SearchError(error: NSError())
          if let results = results {
            if let albumMusicAlbums = results.albums?.data {
              var sources = [CDSource]()
              for appleMusicAlbum in albumMusicAlbums {
                let source = appleMusicAlbum.toSource()
                sources.append(source)
              }
              action = SearchAction.UpdateResults(searchResults: sources)
            } else {
              action = SearchAction.UpdateSearchStatus(newStatus: .noResults)
            }
          }
          if let error = error {
            action = SearchAction.SearchError(error: error)
          }
          promise(.success(action))
        }
      }
      .eraseToAnyPublisher()
    }
  }
  
  struct AddSourceToSlot: FutureAction {
    let sourceId: String
    let slotPosition: Int
    
    func execute() -> AnyPublisher<StateAction, Never> {
      print("adding \(sourceId) to \(slotPosition)")
      
      
      RecordStore.appleMusic.album(id: sourceId, completion: { album, error in
        if let album = album {
          let onRotationFetch: NSFetchRequest<CDCollection> = CDCollection.fetchRequest()
          onRotationFetch.predicate = NSPredicate(format: "type == %@", "onRotation")
          
          let slot: CDSlot
          
          do {
            let onRotation = try PersistenceController.shared.container.viewContext.fetch(onRotationFetch).first
            slot = onRotation?.slots?.first(where: { ($0 as! CDSlot).position == self.slotPosition }) as! CDSlot
          } catch {
            fatalError()
          }
          
          let source = CDSource(context: PersistenceController.shared.container.viewContext)
          source.providerId = album.id
          source.artistName = album.attributes?.artistName
          source.title = album.attributes?.name
          source.artworkURL = album.attributes?.artwork.url(forWidth: 1000)
          source.playbackURL = URL(string: album.href)
          source.slot = slot
          
          do {
            try PersistenceController.shared.container.viewContext.save()
          } catch {
            fatalError()
          }
          
        }
        
//        if let error = error {
//          os_log("💎 Load Album error: %s", String(describing: error))
//          //           TODO: create another action to show an error in album add.
//        }
      })
      return Empty().eraseToAnyPublisher()
    }
  }
  
}
