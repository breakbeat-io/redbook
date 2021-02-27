//
//  redbookApp.swift
//  Shared
//
//  Created by Greg Hepworth on 29/10/2020.
//

import SwiftUI

@main
struct redbookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
