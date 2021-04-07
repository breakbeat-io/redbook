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
  
  @Published private(set) var state = AppState()
  
  private var subscribers: Set<AnyCancellable> = []
  
  init() {
    
    ProfileState.load() { profileState in
      DispatchQueue.main.async {
        self.process(ProfileAction.LoadState(profileState: profileState))
      }
    }
    
    subscribeTo(PersistentProfile.self)
    subscribeTo(PersistentCollection.self)
    subscribeTo(PersistentSlot.self)
    subscribeTo(PersistentSource.self)
  }
  
  func process(_ action: StateAction) {
    Logger.action.log("\(action.logMessage())")
    state = action.updateState(state)
  }
  
  func process<T: FutureAction>(_ action: T) {
    Logger.action.log("\(action.logMessage())")
    action.execute()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { action in
        switch action {
        
        case let stateAction as StateAction:
          self.process(stateAction)
          
        case let futureAction as T:
          self.process(futureAction)
          
        default:
          break
        
        }
      })
      .store(in: &subscribers)
  }
  
  private func subscribeTo<T: NSManagedObject>(_ type: T.Type) {
    let entityPublisher: AnyPublisher<[T], Never> = CoreDataEntityPublisher<T>().entities.eraseToAnyPublisher()
    entityPublisher.sink { entities in
      self.process(CoreDataAction.Update(entities: entities))
    }
    .store(in: &subscribers)
  }
  
}
