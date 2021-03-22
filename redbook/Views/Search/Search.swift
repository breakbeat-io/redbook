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
        SearchBar(searchAction: { searchTerm in
          app.process(SearchAction.UpdateSearchStatus(newStatus: .searching))
          app.process(SearchAction.SearchAppleMusic(searchTerm: searchTerm))
        },
        clearAction: {
          app.process(SearchAction.ClearResults())
        })
        ZStack {
          SearchResults(searchResults: app.state.search.searchResults,
                        addAction: { sourceId in
                          app.process(SearchAction.GetAppleMusicAlbumForSlot(sourceId: sourceId, slotPosition: slotPosition))
                          presentationMode.wrappedValue.dismiss()
                        })
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