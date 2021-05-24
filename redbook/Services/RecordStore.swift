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
  
  static let appleMusic = HMV(storefront: .unitedKingdom, developerToken: Secrets.appleMusicAPIToken)
  
  private init() { }
  
}


