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
    
    @Published var slots = [Slot]()
    
    private var slotSubscriber: AnyCancellable?
    
    init(slotPublisher: AnyPublisher<[Slot], Never> = SlotProvider.shared.slots.eraseToAnyPublisher()) {
      slotSubscriber = slotPublisher.sink { slots in
        self.slots = slots.filter({ $0.collection!.type == "onRotation" })
      }
      
    }
      
    func removeSource(source: Source) {
      SlotProvider.shared.delete(source: source)
    }

  }
}
