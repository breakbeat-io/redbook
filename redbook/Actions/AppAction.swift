//
//  AppAction.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation
import Combine

protocol StateAction {
  func log() -> String
}
protocol FutureAction  {
  func log() -> String
  func execute() -> AnyPublisher<StateAction, Never>
}
