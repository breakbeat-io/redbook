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
  @Binding var isPresented: Bool
  
  var body: some View {
    NavigationView {
      VStack{
        SearchBar(viewModel: viewModel)
        SearchResults(viewModel: viewModel, isPresented: $isPresented)
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
}
