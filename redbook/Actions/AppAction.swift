//
//  AppAction.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation
import Combine

protocol StateAction { }
protocol FutureAction  {
  func execute() -> AnyPublisher<StateAction, Never>
}
