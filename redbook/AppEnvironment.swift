//
//  AppEnvironment.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation
import os
import CoreData
import Combine

final class AppEnvironment: ObservableObject {
  
  @Published private(set) var state = AppState.initial
  
  private var subscribers: Set<AnyCancellable> = []
  private let actionLogger = Logger(subsystem: "io.breakbeat.redbook", category: "action")
  
  init() {
    subscribeTo(PersistentCollection.self)
    subscribeTo(PersistentSlot.self)
    subscribeTo(PersistentSource.self)
  }
  
//  TODO: Really want to make `process` one method that takes an Action, think it needs FutureAction type erased to as follows:
  func process(_ action: Action) {
    actionLogger.log("\(action.logMessage())")

    switch action {

    case let stateAction as StateAction:
      state = updateState(state: state, action: stateAction)

    case let futureAction as AnyFutureAction<Source, Error>:
      futureAction.execute()
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: process)
        .store(in: &subscribers)

    default:
      break
    }
  }
  
//  func process(_ action: StateAction) {
//    actionLogger.log("\(action.logMessage())")
//    state = updateState(state: state, action: action)
//  }
//
//  func process<T: FutureAction>(_ action: T) {
//    actionLogger.log("\(action.logMessage())")
//    action.execute()
//      .receive(on: DispatchQueue.main)
//      .sink(receiveValue: { action in
//        switch action {
//
//        case let stateAction as StateAction:
//          self.process(stateAction)
//
//        case let futureAction as T:
//          self.process(futureAction)
//
//        default:
//          break
//
//        }
//      })
//      .store(in: &subscribers)
//  }
  
  private func subscribeTo<T: NSManagedObject>(_ type: T.Type) {
    let entityPublisher: AnyPublisher<[T], Never> = CoreDataEntityPublisher<T>().entities.eraseToAnyPublisher()
    entityPublisher.sink { entities in
      self.process(LibraryAction.CoreDataUpdate(entities: entities))
    }
    .store(in: &subscribers)
  }
  
}
