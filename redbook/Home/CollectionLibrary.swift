//
//  Library.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI

struct CollectionLibrary: View {
  
  @EnvironmentObject var app: AppEnvironment
  
  var body: some View {
    NavigationView {
      VStack {
        Text("Curator: \(app.state.user.curatorName)")
        Text("Label: \(app.state.user.labelName)")
        Button("Change Curator", action: { app.process(UserAction.ChangeCurator()) })
        Button("Change Label", action: { app.process(UserAction.ChangeLabel()) })
        Button("Change Label Later", action: { app.process(UserAction.FutureChangeLabel()) })
      }
      .navigationTitle("Library")
    }
  }
}

