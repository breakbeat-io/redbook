//
//  OnRotation.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI

struct OnRotation: View {
  
  @EnvironmentObject var app: AppEnvironment
  
  @State private var showProfile = false
  
  private var slots: [Slot] {
    app.state.library.onRotation.slots.sorted(by: { $0.position < $1.position })
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        ForEach(slots, id: \.position) { slot in
          if let source: Source = slot.source {
            NavigationLink(
              destination: SourceDetail(sourceId: source.providerId, showPlaybackLink: true)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                  ToolbarItem(placement: .destructiveAction) {
                    Button {
                      app.process(LibraryAction.RemoveSourceFromSlot(slotPosition: slot.position))
                    } label: {
                      Image(systemName: "eject")
                        .foregroundColor(.red)
                    }
                  }
                }
            ) {
              SourceCard(title: source.title, artist: source.artistName, artworkURL: source.artworkURL)
                .frame(height: 61)
            }
            .contextMenu(ContextMenu(menuItems: {
              Button {
                app.process(LibraryAction.RemoveSourceFromSlot(slotPosition: slot.position))
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
      .toolbar(content: {
        ToolbarItem(placement: .primaryAction) {
          Button {
            showProfile.toggle()
          } label: {
            Image(systemName: "person.fill")
          }
        }
      })
      .sheet(isPresented: $showProfile) {
        Profile()
          .environmentObject(app)
      }
    }
  }
  
}
