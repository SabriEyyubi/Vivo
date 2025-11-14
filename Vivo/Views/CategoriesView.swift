//
//  CategoriesView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var selectedCategory: Category?
    
    // Dummy categories data
    private let categories = [
        Category(id: 1, name: "Teknoloji", icon: "laptopcomputer", topicCount: 25),
        Category(id: 2, name: "Sosyal", icon: "person.2.fill", topicCount: 18),
        Category(id: 3, name: "Bilim", icon: "atom", topicCount: 22),
        Category(id: 4, name: "Sanat", icon: "paintpalette.fill", topicCount: 15),
        Category(id: 5, name: "Spor", icon: "sportscourt.fill", topicCount: 20),
        Category(id: 6, name: "Müzik", icon: "music.note", topicCount: 12),
        Category(id: 7, name: "Film", icon: "tv.fill", topicCount: 16),
        Category(id: 8, name: "Kitap", icon: "book.fill", topicCount: 14),
        Category(id: 9, name: "Yemek", icon: "fork.knife", topicCount: 19),
        Category(id: 10, name: "Seyahat", icon: "airplane", topicCount: 13),
        Category(id: 11, name: "Moda", icon: "tshirt.fill", topicCount: 11),
        Category(id: 12, name: "Sağlık", icon: "heart.fill", topicCount: 17),
        Category(id: 13, name: "Eğitim", icon: "graduationcap.fill", topicCount: 21),
        Category(id: 14, name: "Çevre", icon: "leaf.fill", topicCount: 9),
        Category(id: 15, name: "İş Hayatı", icon: "briefcase.fill", topicCount: 23)
    ]
    
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
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 16) {
                    ForEach(categories) { category in
                        NavigationLink(
                            destination: CategoryTopicsView(category: category),
                            tag: category,
                            selection: $selectedCategory
                        ) {
                            CategoryCard(category: category) {
                                selectedCategory = category
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("categories".localized)
        .navigationBarTitleDisplayMode(.large)
        .onReceive(localizationHelper.$currentLanguage) { _ in
            // Refresh when language changes
        }
    }
}

#Preview {
    CategoriesView()
}
