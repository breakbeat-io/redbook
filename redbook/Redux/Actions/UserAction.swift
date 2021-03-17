//
//  UserAction.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 17/03/2021.
//

import Foundation
import Combine

struct UserAction {
  
  struct ChangeCurator: StateAction { }
  struct ChangeLabel: StateAction { }
  struct FutureChangeLabel: FutureAction {
    func execute() -> AnyPublisher<StateAction, Never> {
      return Future<StateAction, Never> { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          promise(.success(UserAction.ChangeLabel()))
        }
      }.eraseToAnyPublisher()
    }
  }
  
}
