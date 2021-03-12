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
  @State var searchTerm: String = ""
  
  var body: some View {
    NavigationView {
      VStack{
        SearchBar(searchTerm: $searchTerm)
          .onChange(of: searchTerm) { searchTerm in
            viewModel.debouncedSearch(for: searchTerm)
          }
        SearchResults(searchResults: viewModel.searchResults) { sourceId in
          viewModel.addSourceToSlot(albumId: sourceId)
          presentationMode.wrappedValue.dismiss()
        }
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
  }
  
  init(slotPosition: Int) {
    let viewModel = ViewModel(slotPosition: slotPosition)
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
}
