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

protocol StateAction: Action { }

protocol FutureAction: Action {
  
  associatedtype Result
  var nextAction: (Result) -> StateAction { get }
  
  associatedtype ResultError
  var errorAction: (ResultError) -> StateAction { get }
  
  func execute() -> AnyPublisher<StateAction, Never>
}
