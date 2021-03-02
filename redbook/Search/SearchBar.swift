//
//  SearchBar.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 02/03/2021.
//

import SwiftUI

struct SearchBar: View {
  
  @State private var searchTerm: String = ""
  
  var body: some View {
    HStack {
      Text(Image(systemName: "magnifyingglass"))
      TextField(
        "Search music",
        text: $searchTerm,
        onCommit: {
          
        })
        .foregroundColor(.primary)
        .keyboardType(.webSearch)
      Button {
        self.searchTerm = ""
      } label: {
        Text(Image(systemName: "xmark.circle.fill"))
          .opacity(searchTerm == "" ? 0 : 1)
      }
    }
    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
    .foregroundColor(.secondary)
    .background(Color(.secondarySystemBackground))
    .cornerRadius(8.0)
    .padding()
  }
}
