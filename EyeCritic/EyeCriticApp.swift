//
//  EyeCriticApp.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import SwiftUI

@main
struct EyeCriticApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
