//
//  WorkingState.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 23/03/2021.
//

import Foundation

struct ActiveState {
  var source: Source?
  var loadStatus: LoadStatus = .idle
  var loadError: Error?
  
  enum LoadStatus: String {
    case idle = ""
    case loading = "Loading"
    case error = "There was an error, please try again."
  }

}
