//
//  redbookApp.swift
//  Shared
//
//  Created by Greg Hepworth on 29/10/2020.
//

import SwiftUI

@main
struct redbookApp: App {
  
  let app = AppEnvironment()
  let persistenceController = PersistenceController.shared
  
  init() {
    checkKeys()
  }
  
  var body: some Scene {
    WindowGroup {
      Home()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(app)
    }
  }
  
  private func checkKeys() {
    
    precondition(Bundle.main.infoDictionary?["APPLE_MUSIC_API_TOKEN"] as! String != "", """

        ==========
        No Apple Music API Token Found! [APPLE_MUSIC_API_TOKEN]

        Please make sure a valid Apple Music private key, ID and Developer Team ID are
        set in secrets.xcconfig to allow a token to be generated on build by the
        pre-action createAppleMusicAPIToken.sh
        ==========

        """)
  }
  
}
