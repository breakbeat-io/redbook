//
//  PersistentCollection+Extensions.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 21/03/2021.
//

extension PersistentCollection {
  func toCollection() -> Collection {
    Collection(type: Collection.CollectionType(rawValue: self.type!)!, name: name ?? "Collection", curator: curator ?? "Curator")
  }
}
