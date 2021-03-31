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
    
    typealias Result = [Source]
    let success: ([Source]) -> Action
    
    typealias ResultError = Error
    let error: (Error) -> Action
    
    func execute() -> AnyPublisher<Action, Never> {
      return Future() { promise in
        RecordStore.appleMusic.search(term: searchTerm, limit: 20, types: [.albums]) { results, searchError in
          // TODO: Sets action to an Error in case it falls out without processing, feels like could be smarter.
          var action: Action = SearchAction.SearchError(error: NSError())
          if let results = results {
            if let albumMusicAlbums = results.albums?.data {
              var sources = [Source]()
              for appleMusicAlbum in albumMusicAlbums {
                let source = appleMusicAlbum.toSource()
                sources.append(source)
              }
              action = success(sources)
            } else {
              action = SearchAction.UpdateSearchStatus(newStatus: .noResults)
            }
          }
          if let searchError = searchError {
            action = self.error(searchError)
          }
          promise(.success(action))
        }
      }
      .eraseToAnyPublisher()
    }
    
    func logMessage() -> String {
      "🔊 Searching Apple Music for `\(searchTerm)`"
    }
  }
  
  struct GetAppleMusicAlbum: FutureAction {
    let sourceId: String
    
    typealias Result = Source
    let success: (Source) -> Action
    
    typealias ErrorAction = Error
    let error: (Error) -> Action
    
    func execute() -> AnyPublisher<Action, Never> {
      return Future() { promise in
        
        var action: Action = ActiveAction.LoadError(error: NSError())
        
        RecordStore.appleMusic.album(id: sourceId) { album, albumError in
          if let album = album {
            let source = album.toSource()
            action = success(source)
          }
          if let error = albumError {
            action = self.error(error)
          }
          promise(.success(action))
        }
      }
      .eraseToAnyPublisher()
    }
    
    func logMessage() -> String {
      "🔊 Getting Apple Music Album \(sourceId) "
    }
  }
  
}
