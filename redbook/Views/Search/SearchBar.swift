//
//  SearchBar.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 02/03/2021.
//

import Combine
import SwiftUI

struct SearchBar: View {
  
  @State private var searchTerm: String = ""
  private let search: (String) -> Void
  private let clear: () -> Void
  private var debouncerRelay = PassthroughSubject<String,Never>()
  private var debouncer: AnyPublisher<String, Never>
  
  var body: some View {
    VStack {
      HStack {
        Text(Image(systemName: "magnifyingglass"))
        TextField("Search albums", text: $searchTerm)
          .foregroundColor(.primary)
          .keyboardType(.webSearch)
        Button {
          searchTerm = ""
        } label: {
          Text(Image(systemName: "xmark.circle.fill"))
            .opacity(searchTerm == "" ? 0 : 1)
        }
      }
      .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      .foregroundColor(.secondary)
      .background(Color(.secondarySystemBackground))
      .cornerRadius(8.0)
      .padding([.top, .horizontal])
    }
    .onChange(of: searchTerm, perform: { searchTerm in
      searchTerm.isEmpty ? self.clear() : debouncerRelay.send(searchTerm)
    })
    .onReceive(debouncer, perform: { searchTerm in
      search(searchTerm)
    })
  }
  
  init(search: @escaping (String) -> Void, clear: @escaping () -> Void) {
    self.search = search
    self.clear = clear
    
    self.debouncer = debouncerRelay
      .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
      .removeDuplicates()
      .eraseToAnyPublisher()
  }
  
}
