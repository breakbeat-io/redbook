//
//  Search.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 01/03/2021.
//

import SwiftUI

struct Search: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationView {
      VStack{
        SearchBar()
        Spacer()
        SearchResults()
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
}
