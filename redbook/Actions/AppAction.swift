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
  var success: (Result) -> Action { get }
  
  associatedtype ResultError
  var error: (ResultError) -> Action { get }
  
  func execute() -> AnyPublisher<Action, Never>
}

struct AnyFutureAction<Result, ResultError>: FutureAction {
  var success: (Result) -> Action
  var error: (ResultError) -> Action
  
  private let executeClosure: () -> AnyPublisher<Action, Never>
  private let logMessageClosure: () -> String
  
  init<A: FutureAction>(_ futureAction: A) where A.Result == Result, A.ResultError == ResultError {
    success = futureAction.success
    error = futureAction.error
    executeClosure = futureAction.execute
    logMessageClosure = futureAction.logMessage
  }
  
  func execute() -> AnyPublisher<Action, Never> {
    executeClosure()
  }
  
  func logMessage() -> String {
    logMessageClosure()
  }
  
}
