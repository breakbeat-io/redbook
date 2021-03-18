//
//  SearchAction.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 17/03/2021.
//

import Foundation
import Combine

struct SearchAction {
  
  struct UpdateResults: StateAction {
    let searchResults: [Source]
  }
  
  struct ClearResults: StateAction { }
  
  struct AppleMusicSearch: FutureAction {
    let searchTerm: String
    
    func execute() -> AnyPublisher<StateAction, Never> {
      return Future() { promise in
        RecordStore.appleMusic.search(term: searchTerm, limit: 20, types: [.albums]) { results, error in
          if let results = results {
            if let albumMusicAlbums = results.albums?.data {
              var sources = [Source]()
              
              for appleMusicAlbum in albumMusicAlbums {
                let source = appleMusicAlbum.toSource()
                sources.append(source)
              }
              promise(.success(SearchAction.UpdateResults(searchResults: sources)))
            }
          }
          //          if let error = error {
          //            os_log("💎 Record Store > Browse error: %s", String(describing: error))
          //            // TODO: create another action to show an error in search results.
          //          }
        }
      }
      .eraseToAnyPublisher()
    }
  }
  
  struct AddSourceToSlot: FutureAction {
    let sourceId: String
    
    func execute() -> AnyPublisher<StateAction, Never> {
      Empty().eraseToAnyPublisher()
      
//      func addSourceToSlot(sourceId: String) {
//        RecordStore.appleMusic.album(id: sourceId, completion: { album, error in
//          if let album = album {
//            let onRotationFetch: NSFetchRequest<Collection> = Collection.fetchRequest()
//            onRotationFetch.predicate = NSPredicate(format: "type == %@", "onRotation")
//
//            let slot: Slot
//
//            do {
//              let onRotation = try PersistenceController.shared.container.viewContext.fetch(onRotationFetch).first
//              slot = onRotation?.slots?.first(where: { ($0 as! Slot).position == self.slotPosition }) as! Slot
//            } catch {
//              fatalError()
//            }
//
//            let source = Source(context: PersistenceController.shared.container.viewContext)
//            source.providerId = album.id
//            source.artistName = album.attributes?.artistName
//            source.title = album.attributes?.name
//            source.artworkURL = album.attributes?.artwork.url(forWidth: 1000)
//            source.playbackURL = URL(string: album.href)
//            source.slot = slot
//
//            do {
//              try PersistenceController.shared.container.viewContext.save()
//            } catch {
//              fatalError()
//            }
//
//          }
//
//          if let error = error {
//            os_log("💎 Load Album error: %s", String(describing: error))
//            // TODO: create another action to show an error in album add.
//          }
//        })
//      }
    }
  }
  
}
