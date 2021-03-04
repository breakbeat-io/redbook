//
//  RecordStore.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/03/2021.
//

import Foundation
import os.log
import HMV

class RecordStore {
  
  static let appleMusic = HMV(storefront: .unitedKingdom, developerToken: Bundle.main.infoDictionary?["APPLE_MUSIC_API_TOKEN"] as! String)
  
  private init() { }
  
  static func search(for searchTerm: String) {
    appleMusic.search(term: searchTerm, limit: 20, types: [.albums]) { results, error in
      if let results = results {
        if let albums = results.albums?.data {
          os_log("💎 Record Store > Got some albums: %s", albums.description)
        }
      }
      
      if let error = error {
        os_log("💎 Record Store > Browse error: %s", String(describing: error))
        // TODO: create another action to show an error in search results.
      }
    }
  }
  
  //  static func purchase(album appleMusicAlbumId: String, forSlot slotIndex: Int, inCollection collectionId: UUID) {
  //    RecordStore.shared.album(id: appleMusicAlbumId, completion: { appleMusicAlbum, error in
  //      if let album = appleMusicAlbum {
  //        DispatchQueue.main.async {
  //          AppEnvironment.global.update(action: LibraryAction.addSourceToSlot(source: album, slotIndex: slotIndex, collectionId: collectionId))
  //          if let baseUrl = album.attributes?.url {
  //            RecordStore.alternativeSuppliers(for: baseUrl, inCollection: collectionId)
  //          }
  //        }
  //      }
  //
  //      if let error = error {
  //        os_log("💎 Record Store > Purchase error: %s", String(describing: error))
  //        // TODO: create another action to show an error in album add.
  //      }
  //
  //    })
  //  }
  
}
