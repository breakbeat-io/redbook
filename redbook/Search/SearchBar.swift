//
//  SearchBar.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 02/03/2021.
//

import SwiftUI

struct SearchBar: View {
  
  @ObservedObject var viewModel: Search.ViewModel
  
  var body: some View {
    VStack {
      HStack {
        Text(Image(systemName: "magnifyingglass"))
        TextField("Search music", text: $viewModel.searchTerm)
          .foregroundColor(.primary)
          .keyboardType(.webSearch)
        Button {
          viewModel.searchTerm = ""
        } label: {
          Text(Image(systemName: "xmark.circle.fill"))
            .opacity(viewModel.searchTerm == "" ? 0 : 1)
        }
      }
      .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      .foregroundColor(.secondary)
      .background(Color(.secondarySystemBackground))
      .cornerRadius(8.0)
      .padding([.top, .horizontal])
    }
  }
}
