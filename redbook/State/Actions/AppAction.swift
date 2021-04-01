//
//  AppAction.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation
import Combine

protocol Action {
  func logMessage() -> String
}

protocol StateAction: Action {
  func updateState(_ state: AppState) -> AppState
}

protocol FutureAction: Action {
  
  associatedtype Result
  var success: (Result) -> Action { get }
  
  associatedtype ResultError
  var error: (ResultError) -> Action { get }
  
  func execute() -> AnyPublisher<Action, Never>
}
