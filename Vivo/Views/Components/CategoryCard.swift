//
//  CategoryCard.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct CategoryCard: View {
    let category: Category
    let onTap: () -> Void
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.theme(.primaryAccent).opacity(0.15))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: category.icon)
                        .font(.system(.title2, weight: .bold))
                        .foregroundColor(Color.theme(.primaryAccent))
                }
                
                // Content
                VStack(spacing: 4) {
                    Text(category.displayName)
                        .font(.system(.headline, design: .rounded, weight: .bold))
                        .foregroundColor(Color.theme(.primaryText))
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                    
                    Text("topic_count".localized(with: category.topicCount))
                        .font(.system(.caption, design: .rounded, weight: .medium))
                        .foregroundColor(Color.theme(.secondaryText))
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.theme(.cardBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.theme(.primaryAccent).opacity(themeManager.currentTheme == .dark ? 0.1 : 0.05),
                                        Color.theme(.secondaryAccent).opacity(themeManager.currentTheme == .dark ? 0.05 : 0.03),
                                        Color.clear
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme(.border).opacity(themeManager.currentTheme == .dark ? 0.4 : 0.3), lineWidth: 1)
                    )
            )
            .shadow(color: Color.theme(.shadow), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LazyVGrid(columns: [
        GridItem(.flexible()),
        GridItem(.flexible())
    ], spacing: 16) {
        CategoryCard(category: Category(id: 1, key: "technology", name: "Teknoloji", icon: "laptopcomputer", topicCount: 25)) {
            print("Technology tapped")
        }
        
        CategoryCard(category: Category(id: 2, key: "social", name: "Sosyal", icon: "person.2.fill", topicCount: 18)) {
            print("Social tapped")
        }
    }
    .padding()
}
