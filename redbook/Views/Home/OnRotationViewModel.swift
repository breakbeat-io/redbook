//
//  OnRotationViewModel.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 10/03/2021.
//

import Foundation
import CoreData
import Combine

extension OnRotation {
  class ViewModel: ObservableObject {
    
    @Published var slots = [CDSlot]()
    
    private var slotProvider = CDSlotProvider(restrictToCollectionType: "onRotation")
    private var slotSubscriber: AnyCancellable?
    
    init() {      
      let slotPublisher: AnyPublisher<[CDSlot], Never> = slotProvider.slots.eraseToAnyPublisher()
      
      slotSubscriber = slotPublisher.sink { slots in
        self.slots = slots
      }
      
    }
      
    func removeSource(source: CDSource) {
      slotProvider.delete(source: source)
    }

  }
}
