//
//  EyeCriticApp.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import SwiftUI
import Swinject

@main
struct EyeCriticApp: App {
    
    init() {
        AppModules.declareModules()
    }
    
    var body: some Scene {
        WindowGroup {
            LastReviewsScreen()
        }
    }
}
