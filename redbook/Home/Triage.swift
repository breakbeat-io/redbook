//
//  Triage.swift
//  redbook (iOS)
//
//  Created by Greg Hepworth on 27/02/2021.
//

import SwiftUI

struct Triage: View {
  
  @EnvironmentObject var dataController: DataController
  
  var body: some View {
    NavigationView {
      VStack {
        Button("Add Data") {
          dataController.deleteAll()
          try? dataController.createSampleData()
        }
      }
      .navigationTitle("Triage")
    }
  }
}

