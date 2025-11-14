//
//  FavoriteTopicCard.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct FavoriteTopicCard: View {
    let title: String
    let category: String
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with category and heart icon
            HStack {
                Text(category)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .foregroundColor(Color.theme(.primaryText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.theme(.primaryAccent).opacity(0.15))
                    )
                
                Spacer()
                
                // Heart icon
                Image(systemName: "heart.fill")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            // Title
            Text(title)
                .font(.system(.body, design: .rounded, weight: .bold))
                .foregroundColor(Color.theme(.primaryText))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(12)
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.theme(.cardBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
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
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.theme(.border).opacity(themeManager.currentTheme == .dark ? 0.3 : 0.2), lineWidth: 1)
                )
        )
        .shadow(color: Color.theme(.shadow), radius: 6, x: 0, y: 2)
    }
}

#Preview {
    HStack(spacing: 12) {
        FavoriteTopicCard(
            title: "Yapay Zeka ve İnsanlık",
            category: "Teknoloji"
        )
        
        FavoriteTopicCard(
            title: "Sosyal Medya Etkisi",
            category: "Sosyal"
        )
    }
    .padding()
}
