//
//  HotTopicCard.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct HotTopicCard: View {
    let title: String
    let description: String
    let difficulty: String
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Difficulty badge
            HStack {
                Text(difficulty)
                    .font(.system(.caption, design: .rounded, weight: .bold))
                    .foregroundColor(Color.theme(.primaryText))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.theme(.secondaryAccent).opacity(0.2))
                    )
                
                Spacer()
                
                // Hot icon
                Text("🔥")
                    .font(.title3)
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
                                    Color.theme(.secondaryAccent).opacity(themeManager.currentTheme == .dark ? 0.15 : 0.1),
                                    Color.theme(.primaryAccent).opacity(themeManager.currentTheme == .dark ? 0.1 : 0.05),
                                    Color.clear
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.theme(.border).opacity(themeManager.currentTheme == .dark ? 0.4 : 0.3), lineWidth: 1)
                )
        )
        .shadow(color: Color.theme(.shadow), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    HotTopicCard(
        title: "Yapay Zeka ve İnsanlık",
        description: "AI teknolojisinin gelecekte insanlığı nasıl etkileyeceği hakkında derinlemesine tartışma",
        difficulty: "Zor"
    )
    .padding()
}
