//
//  OnRotation.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI

struct OnRotation: View {
  
  @StateObject var viewModel = ViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView {
        ForEach(viewModel.slots) { slot in
          if let source: Source = slot.source {
            NavigationLink(
              destination: SourceDetail(sourceId: source.sourceProviderId, showPlaybackLink: true)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                  ToolbarItem(placement: .destructiveAction) {
                    Button {
                      viewModel.removeSource(source: source)
                    } label: {
                      Image(systemName: "eject")
                        .foregroundColor(.red)
                    }
                  }
                }
            ) {
              SourceCard(title: source.sourceName, artist: source.sourceArtist, artworkURL: source.sourceArtworkURL)
                .frame(height: 61)
            }
            .contextMenu(ContextMenu(menuItems: {
              Button {
                viewModel.removeSource(source: source)
              } label: {
                Label("Remove", systemImage: "eject")
              }
              Button {
                //
              } label: {
                Label("Share", systemImage: "square.and.arrow.up")
              }
              .disabled(true)
            }))
          } else {
            EmptyCard(slotPosition: Int(slot.position))
              .frame(height: 61)
          }
        }
      }
      .padding(.horizontal)
      .navigationTitle("On Rotation")
    }
  }
  
}
