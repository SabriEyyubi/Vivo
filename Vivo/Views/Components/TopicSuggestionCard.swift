//
//  TopicSuggestionCard.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct TopicSuggestionCard: View {
    let title: String
    let description: String
    let category: String
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with category and suggestion icon
            HStack {
                Text(category)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .foregroundColor(Color.theme(.primaryText))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.theme(.primaryAccent).opacity(0.15))
                    )
                
                Spacer()
                
                // Suggestion icon
                Image(systemName: "lightbulb.fill")
                    .font(.title3)
                    .foregroundColor(Color.theme(.secondaryAccent))
            }
            
            // Title
            Text(title)
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundColor(Color.theme(.primaryText))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            // Description
            Text(description)
                .font(.system(.caption, design: .rounded, weight: .medium))
                .foregroundColor(Color.theme(.secondaryText))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme(.cardBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.theme(.secondaryAccent).opacity(themeManager.currentTheme == .dark ? 0.1 : 0.05),
                                    Color.theme(.primaryAccent).opacity(themeManager.currentTheme == .dark ? 0.05 : 0.03),
                                    Color.clear
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.theme(.border).opacity(themeManager.currentTheme == .dark ? 0.3 : 0.2), lineWidth: 1)
                )
        )
        .shadow(color: Color.theme(.shadow), radius: 8, x: 0, y: 3)
    }
}

#Preview {
    TopicSuggestionCard(
        title: "Yapay Zeka ve İnsanlık",
        description: "Bu konu size özel olarak öneriliyor",
        category: "Teknoloji"
    )
    .padding()
}
