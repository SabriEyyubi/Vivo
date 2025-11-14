//
//  ZodiacTopicCard.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct ZodiacTopicCard: View {
    @StateObject private var themeManager = ThemeManager.shared
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 16) {
                // Header with zodiac icon and title
                HStack {
                    // Zodiac icon
                    Text("♈")
                        .font(.system(size: 32))
                        .foregroundColor(Color.theme(.primaryAccent))
                    
                    Spacer()
                    
                    // Arrow icon
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.theme(.primaryAccent))
                }
                
                // Title
                Text("zodiac_topics".localized)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundColor(Color.theme(.primaryText))
                    .multilineTextAlignment(.leading)
                
                // Description
                Text("zodiac_topics_description".localized)
                    .font(.system(.body, design: .rounded, weight: .medium))
                    .foregroundColor(Color.theme(.secondaryText))
                    .opacity(themeManager.currentTheme == .dark ? 0.9 : 1.0)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                // Call to action
                HStack {
                    Text("find_perfect_topics".localized)
                        .font(.system(.caption, design: .rounded, weight: .semibold))
                        .foregroundColor(Color.theme(.primaryAccent))
                    
                    Spacer()
                    
                    Text("based_on_zodiac".localized)
                        .font(.system(.caption, design: .rounded, weight: .medium))
                        .foregroundColor(Color.theme(.secondaryText))
                        .opacity(0.8)
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.theme(.cardBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.theme(.primaryAccent).opacity(themeManager.currentTheme == .dark ? 0.15 : 0.08),
                                        Color.theme(.secondaryAccent).opacity(themeManager.currentTheme == .dark ? 0.1 : 0.05),
                                        Color.clear
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.theme(.primaryAccent).opacity(0.3),
                                        Color.theme(.secondaryAccent).opacity(0.2)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    )
            )
            .shadow(color: Color.theme(.shadow), radius: 15, x: 0, y: 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

