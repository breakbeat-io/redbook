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
            app.process(SearchAction.UpdateSearchStatus(newStatus: .searching))
            app.process(SearchAction.AppleMusicSearch(searchTerm: searchTerm))
          },
          clear: {
            app.process(SearchAction.ClearResults())
          }
        )
        ZStack {
          SearchResults(searchResults: app.state.search.searchResults) { sourceId in
            app.process(SearchAction.AddSourceToSlot(sourceId: sourceId))
            presentationMode.wrappedValue.dismiss()
          }
          .disabled(app.state.search.searchStatus == .searching)
          
          switch app.state.search.searchStatus {
          case .searching:
            ActivityIndicator(style: .large)
          case .noResults:
            Text("There were no results, please try again.")
              .foregroundColor(.secondary)
          case .error:
            Text("There was an error, please try again.")
              .foregroundColor(.secondary)
          case .idle:
            EmptyView()
          }
        }
        .frame(maxHeight: .infinity)
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
      app.process(SearchAction.UpdateSearchStatus(newStatus: .idle))
      app.process(SearchAction.ClearResults())
    }
  }
  
}
