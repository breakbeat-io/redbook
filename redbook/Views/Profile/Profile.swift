//
//  Settings.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 02/03/2021.
//

import SwiftUI

struct Profile: View {
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var app: AppEnvironment
  
  @State private var curator: String = ""
  
  var body: some View {
    NavigationView {
      Form {
        HStack{
          Text("Curator")
          TextField(curator,
                    text: $curator,
                    onEditingChanged: { _ in
                      updateCurator()
                    })
            .foregroundColor(.secondary)
        }
      }
      .navigationTitle("Profile")
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
    .onAppear {
      curator = app.state.profile.curator
    }
  }
  
  private func updateCurator() {
    curator = curator.trimmingCharacters(in: .whitespaces)
    if !curator.isEmpty && curator != app.state.profile.curator {
      app.process(ProfileAction.UpdateCurator(curator: curator))
    }
  }
  
}
