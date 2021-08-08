//
//  EyeCriticApp.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import SwiftUI

@main
struct EyeCriticApp: App {
    
    init() {
        AppModules.declareModules()
    }
    
    var body: some Scene {
        WindowGroup {
            ReviewTabView()
        }
    }
}
