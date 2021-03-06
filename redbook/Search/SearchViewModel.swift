//
//  SearchViewModel.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 06/03/2021.
//

import Foundation
import os.log
import HMV

extension Search {
  
  class ViewModel: ObservableObject {
    
    @Published private(set) var searchResults: [Album] = []
    
    var searchTimer: Timer?
    
    // TODO: do I ever need a non-debounced search?
    func debouncedSearch(for searchTerm: String) {
      searchTimer?.invalidate()
      searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
        DispatchQueue.main.async {
          if searchTerm == "" {
            self.clearResults()
          } else {
            self.search(for: searchTerm)
          }
        }
      }
    }
    
    func search(for searchTerm: String) {
      RecordStore.appleMusic.search(term: searchTerm, limit: 20, types: [.albums]) { results, error in
        if let results = results {
          if let albums = results.albums?.data {
            DispatchQueue.main.async {
              self.searchResults = albums
            }
          }
        }
        
        if let error = error {
          os_log("💎 Record Store > Browse error: %s", String(describing: error))
          // TODO: create another action to show an error in search results.
        }
      }
    }
    
    func clearResults() {
      searchResults = []
    }
  }
}
