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
        SearchBar(search: { searchTerm in
          app.process(SearchAction.UpdateSearchStatus(newStatus: .searching))
          app.process(SearchAction.SearchAppleMusic(searchTerm: searchTerm,
                                                    success: { sources in
                                                      SearchAction.UpdateResults(searchResults: sources)
                                                    },
                                                    error: { error in
                                                      SearchAction.SearchError(error: error)
                                                    }))
        },
        clear: {
          app.process(SearchAction.ClearResults())
        })
        ZStack {
          SearchResults(searchResults: app.state.search.searchResults,
                        add: { sourceId in
                          app.process(SearchAction.GetAppleMusicAlbum(sourceId: sourceId,
                                                                      success: { source -> StateAction in
                                                                        LibraryAction.AddSourceToSlot(source: source, slotPosition: slotPosition)
                                                                      },
                                                                      error: { error in
                                                                        SearchAction.SearchError(error: error)
                                                                      }))
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
      app.process(SearchAction.ClearResults())
    }
  }
  
}
