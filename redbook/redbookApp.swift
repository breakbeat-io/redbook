//
//  redbookApp.swift
//  Shared
//
//  Created by Greg Hepworth on 29/10/2020.
//

import SwiftUI

@main
struct redbookApp: App {
  
  @StateObject var dataController: DataController
  
  init() {
    let dataController = DataController.shared
    _dataController = StateObject(wrappedValue: dataController)
    
    dataController.bootstrap()
    
  }
  
  var body: some Scene {
    WindowGroup {
      Home()
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
  }
}
