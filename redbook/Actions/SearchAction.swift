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
    
    func logMessage() -> String {
      "🔊 Setting search status to \(newStatus)"
    }
  }
  
  struct UpdateResults: StateAction {
    let searchResults: [Source]
    
    func logMessage() -> String {
      "🔊 Populating \(searchResults.count) search results"
    }
  }
  
  struct ClearResults: StateAction {
    func logMessage() -> String {
      "🔊 Clearing search results"
    }
  }
  
  struct SearchError: StateAction {
    let error: Error
    
    func logMessage() -> String {
      "🔊 Search error: \(error.localizedDescription)"
    }
  }
  
  struct SearchAppleMusic: FutureAction {
    let searchTerm: String
    
    func logMessage() -> String {
      "🔊 Searching Apple Music for `\(searchTerm)`"
    }
    
    func execute() -> AnyPublisher<StateAction, Never> {
      return Future() { promise in
        RecordStore.appleMusic.search(term: searchTerm, limit: 20, types: [.albums]) { results, error in
          // TODO: Sets action to an Error in case it falls out without processing, feels like could be smarter.
          var action: StateAction = SearchAction.SearchError(error: NSError())
          if let results = results {
            if let albumMusicAlbums = results.albums?.data {
              var sources = [Source]()
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
  
  struct GetAppleMusicAlbumForSlot: FutureAction {
    let sourceId: String
    let slotPosition: Int
    
    func logMessage() -> String {
      "🔊 Getting Apple Music Album \(sourceId) for slot \(slotPosition)"
    }
    
    func execute() -> AnyPublisher<StateAction, Never> {
      return Future() { promise in
        
        var action: StateAction = SearchAction.SearchError(error: NSError())
        
        RecordStore.appleMusic.album(id: sourceId) { album, error in
          if let album = album {
            let source = album.toSource()
            action = LibraryAction.AddSourceToSlot(source: source, slotPosition: slotPosition)
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
  
  struct GetAppleMusicAlbum: FutureAction {
    let sourceId: String
    
    func logMessage() -> String {
      "🔊 Getting Apple Music Album \(sourceId)"
    }
    
    func execute() -> AnyPublisher<StateAction, Never> {
      return Future() { promise in
        
        var action: StateAction = SearchAction.SearchError(error: NSError())
        
        RecordStore.appleMusic.album(id: sourceId) { appleMusicAlbum, error in
          if let appleMusicAlbum = appleMusicAlbum {
              let source = appleMusicAlbum.toSource()
  //            self.tracks = appleMusicAlbum.toTracks()
              action = ActiveAction.LoadSource(source: source)
          }
          if let error = error {
            // TODO: create another action to show an error in album add.
          }
          promise(.success(action))
        }
      }
      .eraseToAnyPublisher()
    }
    
  }
  
}
