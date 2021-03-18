//
//  Search.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 01/03/2021.
//

import os.log
import SwiftUI

struct Search: View {
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var app: AppEnvironment
  
  let slotPosition: Int
  
  var body: some View {
    NavigationView {
      VStack{
        SearchBar(
          search: { (searchTerm) in
            app.process(SearchAction.AppleMusicSearch(searchTerm: searchTerm))
          },
          clear: {
            app.process(SearchAction.ClearResults())
          }
        )
        SearchResults(searchResults: app.state.search.searchResults) { sourceId in
          app.process(SearchAction.AddSourceToSlot(sourceId: sourceId))
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
    .onDisappear {
      app.process(SearchAction.ClearResults())
    }
  }
  
}
