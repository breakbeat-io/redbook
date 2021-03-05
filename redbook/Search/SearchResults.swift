//
//  SearchResults.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 02/03/2021.
//

import SwiftUI
import HMV

struct SearchResults: View {
  
  let searchResults: [Album]
  
  var body: some View {
    ForEach(searchResults) { album in
      Text(album.attributes!.name)
    }
  }
}
