//
//  AppEnvironment.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 16/03/2021.
//

import Foundation
import CoreData
import Combine

final class AppEnvironment: ObservableObject {
  
  @Published private(set) var state = AppState.initial

  private var subscribers: Set<AnyCancellable> = []
  
  init() {
    subscribeTo(PersistentCollection.self)
    subscribeTo(PersistentSlot.self)
    subscribeTo(PersistentSource.self)
  }
  
  func process(_ action: StateAction) {
    print(action.log())
    state = updateState(state: state, action: action)
  }
  
  func process(_ action: FutureAction) {
    print(action.log())
    action.execute()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { action in self.process(action) })
      .store(in: &subscribers)
  }
  
  private func subscribeTo<T: NSManagedObject>(_ type: T.Type) {
    let entityPublisher: AnyPublisher<[T], Never> = CoreDataEntityPublisher<T>().entities.eraseToAnyPublisher()
    entityPublisher.sink { entities in
      self.process(LibraryAction.CoreDataUpdate(entities: entities))
    }
    .store(in: &subscribers)
  }
  
}
