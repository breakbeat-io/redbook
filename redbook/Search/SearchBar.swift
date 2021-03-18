//
//  SearchBar.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 02/03/2021.
//

import Combine
import SwiftUI

struct SearchBar: View {
  
  @StateObject var viewModel: ViewModel
  
  var body: some View {
    VStack {
      HStack {
        Text(Image(systemName: "magnifyingglass"))
        TextField("Search albums", text: $viewModel.searchTerm)
          .foregroundColor(.primary)
          .keyboardType(.webSearch)
        Button {
          viewModel.searchTerm = ""
        } label: {
          Text(Image(systemName: "xmark.circle.fill"))
            .opacity(viewModel.searchTerm == "" ? 0 : 1)
        }
      }
      .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      .foregroundColor(.secondary)
      .background(Color(.secondarySystemBackground))
      .cornerRadius(8.0)
      .padding([.top, .horizontal])
    }
  }
  
  init(search: @escaping (String) -> Void, clear: @escaping () -> Void) {
    let viewModel = ViewModel(search: search, clear: clear)
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
}

extension SearchBar {
  
  class ViewModel: ObservableObject {
    
    @Published var searchTerm: String = "" {
      didSet {
        searchTerm.isEmpty ? self.clear() : ()
      }
    }
    private var searchTermSubscriber: Set<AnyCancellable> = []
    private let search: (String) -> Void
    private let clear: () -> Void
    
    init(search: @escaping (String) -> Void, clear: @escaping () -> Void) {
      self.search = search
      self.clear = clear
      debounceSearch()
    }
    
    private func debounceSearch() {
      $searchTerm
        .dropFirst(2)
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .removeDuplicates()
        .filter{ !$0.isEmpty }
        .compactMap{ $0 }
        .sink(receiveValue: { searchTerm in
          self.search(searchTerm)
        })
        .store(in: &searchTermSubscriber)
    }
    
  }
}
