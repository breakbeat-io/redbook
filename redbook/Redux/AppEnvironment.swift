//
//  AppEnvironment.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation
import Combine

final class AppEnvironment: ObservableObject {
  
  @Published private(set) var state: AppState
  
  private var asyncActionSubscribers: Set<AnyCancellable> = []
  
  init(initialState: AppState) {
    self.state = initialState
  }
  
  func process(_ action: StateAction) {
    state = updateState(state: state, action: action)
  }
  
  func process(_ action: FutureAction) {
    action.execute()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { self.process($0) })
      .store(in: &asyncActionSubscribers)
  }
  
}
