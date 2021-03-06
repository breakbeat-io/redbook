//
//  Search.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 01/03/2021.
//

import os.log
import SwiftUI
import HMV

struct Search: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  @StateObject var viewModel: ViewModel
  @State private var searchTerm: String = ""
  
  var body: some View {
    NavigationView {
      VStack{
        SearchBar(searchTerm: $searchTerm)
        SearchResults(searchResults: viewModel.searchResults)
      }
      .navigationBarTitle("Add Album", displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Text("Close")
          }
        }
      }
    }
    .onChange(of: searchTerm, perform: { searchTerm in
      viewModel.debouncedSearch(for: searchTerm)
    })
  }
}
