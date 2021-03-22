//
//  AppAction.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation
import Combine

protocol Action {
  func log() -> String
}

protocol StateAction: Action { }

protocol FutureAction: Action {
  func execute() -> AnyPublisher<StateAction, Never>
}
