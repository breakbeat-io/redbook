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
  
  @StateObject var viewModel: ViewModel
  @Binding var isPresented: Bool
  
  var body: some View {
    NavigationView {
      VStack{
        SearchBar(viewModel: viewModel)
        SearchResults(searchResults: viewModel.searchResults) { albumId in
          viewModel.addAlbumToSlot(albumId: albumId)
          isPresented = false
        }
      }
      .navigationBarTitle("Add Album", displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button {
            isPresented = false
          } label: {
            Text("Close")
          }
        }
      }
    }
  }
  
  init(slotPosition: Int, isPresented: Binding<Bool>) {
    let viewModel = ViewModel(slotPosition: slotPosition)
    _viewModel = StateObject(wrappedValue: viewModel)
    self._isPresented = isPresented
  }
  
}
