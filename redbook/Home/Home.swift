//
//  Home.swift
//  Shared
//
//  Created by Greg Hepworth on 29/10/2020.
//

import SwiftUI
import CoreData

struct Home: View {
  
  var body: some View {
    TabView {
      OnRotation()
        .tabItem {
          Image(systemName: "music.house")
          Text("On Rotation")
        }
      
      CollectionLibrary()
        .tabItem {
          Image(systemName: "rectangle.on.rectangle.angled")
          Text("Library")
        }
      
      Triage()
        .tabItem {
          Image(systemName: "tray")
          Text("Triage")
        }
    }
  }
}
