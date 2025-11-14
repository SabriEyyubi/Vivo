//
//  HomeView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var refreshID = UUID()
    let onTabChange: (Int) -> Void
    
    var body: some View {
        ZStack {
            // Beautiful gradient background
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.theme(.gradientStart).opacity(themeManager.currentTheme == .dark ? 0.4 : 0.3),
                    Color.theme(.gradientMiddle).opacity(themeManager.currentTheme == .dark ? 0.3 : 0.2),
                    Color.theme(.primaryBackground)
                ]),
                center: .topLeading,
                startRadius: 100,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            // Additional subtle gradient overlay
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.theme(.gradientEnd).opacity(themeManager.currentTheme == .dark ? 0.15 : 0.1),
                    Color.clear,
                    Color.theme(.gradientStart).opacity(themeManager.currentTheme == .dark ? 0.15 : 0.1)
                ]),
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
            .ignoresSafeArea()
            
            // Daily Topics Section
            DailyTopicsView(onTabChange: onTabChange)
            
        }
        .onReceive(localizationHelper.$currentLanguage) { _ in
            refreshID = UUID()
        }
    }
}


