//
//  ContentView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var refreshID = UUID()
    @State private var isLoggedIn = false
    
    var body: some View {
        Group {
            if isLoggedIn {
                MainTabView()
            } else {
                LoginView {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isLoggedIn = true
                    }
                }
            }
        }
        .environmentObject(localizationHelper)
        .environmentObject(themeManager)
    }
}

struct OldContentView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var refreshID = UUID()
    
    var body: some View {
        ZStack {
            // Background with theme colors
            Color.theme(.primaryBackground)
                .ignoresSafeArea()
            
            // Main content
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Text("🌍 Language Selector Demo")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme(.primaryText))
                            .multilineTextAlignment(.center)
                        
                        Text("Tap the language button in the top-right corner!")
                            .font(.subheadline)
                            .foregroundColor(Color.theme(.secondaryText))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Current language card
                    VStack(spacing: 15) {
                        HStack {
                            Text("🎯")
                                .font(.title2)
                            Text("Current Language:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme(.primaryText))
                        }
                        
                        HStack(spacing: 10) {
                            Text(localizationHelper.currentLanguage.flag)
                                .font(.title)
                            
                            Text(localizationHelper.currentLanguage.displayName)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme(.primaryAccent))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.theme(.primaryAccent).opacity(0.1))
                        )
                    }
                    .padding()
                    .background(Color.theme(.cardBackground))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme(.border), lineWidth: 1)
                    )
                    .shadow(color: Color.theme(.shadow), radius: 10, x: 0, y: 5)
                    .id(refreshID)
                    
                    // Sample text cards
                    VStack(spacing: 20) {
                        Text("✨ Sample Localized Text:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme(.primaryText))
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 15) {
                            LocalizedTextCard(icon: "🏠", key: "home", value: "home".localized)
                            LocalizedTextCard(icon: "🔍", key: "search", value: "search".localized)
                            LocalizedTextCard(icon: "👤", key: "profile", value: "profile".localized)
                            LocalizedTextCard(icon: "⚙️", key: "settings", value: "settings".localized)
                        }
                    }
                    .padding()
                    .background(Color.theme(.cardBackground))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme(.border), lineWidth: 1)
                    )
                    .shadow(color: Color.theme(.shadow), radius: 10, x: 0, y: 5)
                    .id(refreshID)
                    
                    // Fun facts
                    VStack(spacing: 15) {
                        Text("💡 Fun Facts:")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme(.primaryText))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            FunFactRow(icon: "🌍", text: "Supports 3 languages: English, Turkish, Spanish")
                            FunFactRow(icon: "⚡", text: "Real-time language switching")
                            FunFactRow(icon: "💾", text: "Remembers your choice")
                            FunFactRow(icon: "🎨", text: "Beautiful animations")
                        }
                    }
                    .padding()
                    .background(Color.theme(.cardBackground))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme(.border), lineWidth: 1)
                    )
                    .shadow(color: Color.theme(.shadow), radius: 10, x: 0, y: 5)
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 20)
            }
            
            // Language selector in top-right corner
            LanguageSelectorButton(position: .topTrailing, style: .compact)
            
            // Theme selector in top-left corner
            ThemeSelectorButton(position: .topLeading)
        }
        .onReceive(localizationHelper.$currentLanguage) { _ in
            refreshID = UUID()
        }
    }
}

struct LocalizedTextCard: View {
    let icon: String
    let key: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(icon)
                .font(.title2)
            
            Text(key)
                .font(.caption)
                .foregroundColor(Color.theme(.secondaryText))
                .fontWeight(.medium)
            
            Text(value)
                .font(.body)
                .fontWeight(.semibold)
                                .foregroundColor(Color.theme(.primaryText))
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.theme(.primaryBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.theme(.border), lineWidth: 1)
                )
        )
    }
}

struct FunFactRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text(icon)
                .font(.title3)
            
            Text(text)
                .font(.body)
                                .foregroundColor(Color.theme(.primaryText))
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}

#Preview("Login View") {
    LoginView {
        print("Login successful")
    }
}


