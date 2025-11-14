//
//  VivoApp.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

@main
struct VivoApp: App {
    
    init() {
        // Configure Realm when app starts
        RealmSetup.configureRealm()
        RealmSetup.seedSampleData()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
