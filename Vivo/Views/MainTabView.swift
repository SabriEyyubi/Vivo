//
//  MainTabView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
            // Home Tab
            HomeView { tabIndex in
                selectedTab = tabIndex
            }
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("home".localized)
                }
                .tag(0)
            
            // Categories Tab
            NavigationStack {
                CategoriesView()
            }
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "square.grid.2x2.fill" : "square.grid.2x2")
                    Text("categories".localized)
                }
                .tag(1)
            
            // Discover Tab
            NavigationStack {
                DiscoverView()
            }
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "magnifyingglass.circle.fill" : "magnifyingglass.circle")
                    Text("discover".localized)
                }
                .tag(2)
            
            // AI Tab
            AIView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "brain.head.profile.fill" : "brain.head.profile")
                    Text("ai".localized)
                }
                .tag(3)
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.circle.fill" : "person.circle")
                    Text("profile".localized)
                }
                .tag(4)
        }
        .accentColor(Color.theme(.primaryAccent))
        .onAppear {
            updateTabBarAppearance()
        }
        .onReceive(themeManager.$currentTheme) { _ in
            DispatchQueue.main.async {
                updateTabBarAppearance()
            }
        }
        .onReceive(localizationHelper.$currentLanguage) { _ in
            // Refresh when language changes
        }
        
        }
    }
    
    private func updateTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Background with theme-appropriate colors
        let backgroundColor = themeManager.currentTheme == .dark ? 
            Color.theme(.primaryBackground) : Color.theme(.cardBackground)
        appearance.backgroundColor = UIColor(backgroundColor)
        
        // Remove any existing background image
        appearance.backgroundImage = nil
        
        // Normal state
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.theme(.secondaryText))
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme(.secondaryText))
        ]
        
        // Selected state
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.theme(.primaryAccent))
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme(.primaryAccent))
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - UIImage Extension for Gradient
extension UIImage {
    static func fromGradientLayer(_ layer: CAGradientLayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

#Preview {
    MainTabView()
}
