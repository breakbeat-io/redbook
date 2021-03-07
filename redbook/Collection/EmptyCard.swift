//
//  EmptyCard.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 01/03/2021.
//

import SwiftUI

struct EmptyCard: View {

  @State private var showSearch = false
  let slotPosition: Int

  var body: some View {
    Button {
      showSearch.toggle()
    } label: {
      RoundedRectangle(cornerRadius: CSS.cardCornerRadius)
        .foregroundColor(Color(UIColor.secondarySystemBackground))
        .overlay(
          Text(Image(systemName: "plus"))
            .font(.headline)
            .foregroundColor(.secondary)
        )
    }
    .sheet(isPresented: $showSearch) {
      Search(viewModel: .init(slotPosition: slotPosition))
    }
  }
}
