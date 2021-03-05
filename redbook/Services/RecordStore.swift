//
//  RecordStore.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/03/2021.
//

import Foundation
import os.log
import HMV

struct RecordStore {
  
  static let appleMusic = HMV(storefront: .unitedKingdom, developerToken: Bundle.main.infoDictionary?["APPLE_MUSIC_API_TOKEN"] as! String)
  
  private init() { }
  
}
