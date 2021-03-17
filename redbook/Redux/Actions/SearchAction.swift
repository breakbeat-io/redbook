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
    }
  }
  
}
