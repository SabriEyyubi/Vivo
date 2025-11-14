//
//  ProfileView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var showingLogoutAlert = false
    @State private var showingFavoritesView = false
    
    var body: some View {
        ZStack {
            // Beautiful gradient background (same as HomeView)
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
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 16) {
                        // Profile Avatar
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.theme(.primaryAccent),
                                            Color.theme(.secondaryAccent)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "person.fill")
                                .font(.system(.title, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 4) {
                            Text("profile_title".localized)
                                .font(.system(.title2, design: .rounded, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.theme(.primaryText),
                                            Color.theme(.primaryText).opacity(0.8)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            
                            Text("profile_subtitle".localized)
                                .font(.system(.body, design: .rounded, weight: .medium))
                                .foregroundColor(Color.theme(.secondaryText))
                                .opacity(themeManager.currentTheme == .dark ? 0.9 : 1.0)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Settings Section
                    VStack(spacing: 16) {
                        Text("settings".localized)
                            .font(.system(.title3, design: .rounded, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.theme(.primaryText),
                                        Color.theme(.primaryText).opacity(0.8)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            // Theme Setting
                            SettingRow(
                                icon: "sun.max.fill",
                                title: "theme".localized,
                                subtitle: themeManager.currentTheme == .light ? "light_mode".localized : "dark_mode".localized
                            ) {
                                themeManager.toggleTheme()
                            }
                            
                            // Language Setting
                            SettingRow(
                                icon: "globe",
                                title: "language".localized,
                                subtitle: localizationHelper.currentLanguage.displayName
                            ) {
                                localizationHelper.toggleLanguage()
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Favorites Section
                    VStack(spacing: 16) {
                        Button(action: {
                            showingFavoritesView = true
                        }) {
                            HStack {
                                Text("favorites".localized)
                                    .font(.system(.title3, design: .rounded, weight: .bold))
                                    .foregroundStyle(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color.theme(.primaryText),
                                                Color.theme(.primaryText).opacity(0.8)
                                            ]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                
                                Spacer()
                                
                                HStack(spacing: 8) {
                                    Text("3")
                                        .font(.system(.caption, design: .rounded, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(
                                            Capsule()
                                                .fill(Color.theme(.primaryAccent))
                                        )
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(.caption, weight: .bold))
                                        .foregroundColor(Color.theme(.secondaryText))
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(0..<3) { index in
                                    FavoriteTopicCard(
                                        title: "Beğenilen Konu \(index + 1)",
                                        category: index % 2 == 0 ? "Teknoloji" : "Sosyal"
                                    )
                                    .frame(width: 200)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    Spacer()
                    
                    // Logout Section
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(.title3, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("logout".localized)
                                .font(.system(.headline, design: .rounded, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.theme(.primaryAccent),
                                            Color.theme(.secondaryAccent)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                }
            }
        }
        .alert("logout_confirmation".localized, isPresented: $showingLogoutAlert) {
            Button("cancel".localized, role: .cancel) { }
            Button("logout".localized, role: .destructive) {
                // Handle logout
                print("User logged out")
            }
        } message: {
            Text("logout_message".localized)
        }
        .sheet(isPresented: $showingFavoritesView) {
            FavoritesView()
        }
        .onReceive(localizationHelper.$currentLanguage) { _ in
            // Refresh when language changes
        }
    }
}

#Preview {
    ProfileView()
}
