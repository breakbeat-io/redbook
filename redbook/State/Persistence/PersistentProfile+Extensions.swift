//
//  PersistentProfile+Extensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 04/04/2021.
//

import Foundation

extension PersistentProfile {
  func toState() -> ProfileState {
    return ProfileState(curator: curator!)
  }
}
