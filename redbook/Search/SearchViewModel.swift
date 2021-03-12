//
//  SearchViewModel.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 06/03/2021.
//

import Foundation
import os.log
import CoreData
import HMV

extension Search {
  
  class ViewModel: ObservableObject {
    
    @Published private(set) var searchResults: [AppleMusicAlbum] = []
    
    // TODO: not sure whether to keep slotPosition tucked into the VM or should be passed in from the view 🤔
    private var slotPosition: Int
    private var searchTimer: Timer?
    
    init(slotPosition: Int) {
      self.slotPosition = slotPosition
    }
    
    func debouncedSearch(for searchTerm: String) {
      searchTimer?.invalidate()
      searchTimer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
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
    
    func addSourceToSlot(albumId: String) {
      RecordStore.appleMusic.album(id: albumId, completion: { album, error in
        if let album = album {
          let onRotationFetch: NSFetchRequest<Collection> = Collection.fetchRequest()
          onRotationFetch.predicate = NSPredicate(format: "type == %@", "onRotation")
          
          let slot: Slot
          
          do {
            let onRotation = try DataController.shared.container.viewContext.fetch(onRotationFetch).first
            slot = onRotation?.slots?.first(where: { ($0 as! Slot).position == self.slotPosition }) as! Slot
          } catch {
            fatalError()
          }
          
          let source = Source(context: DataController.shared.container.viewContext)
          source.providerId = album.id
          source.artist = album.attributes?.artistName
          source.title = album.attributes?.name
          source.artworkURL = album.attributes?.artwork.url(forWidth: 1000)
          source.playbackURL = URL(string: album.href)
          source.slot = slot
          
          do {
            try DataController.shared.container.viewContext.save()
          } catch {
            fatalError()
          }
          
        }
        
        if let error = error {
          os_log("💎 Load Album error: %s", String(describing: error))
          // TODO: create another action to show an error in album add.
        }
      })
    }
    
  }
}
