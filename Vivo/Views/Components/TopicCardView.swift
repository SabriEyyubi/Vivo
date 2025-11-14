//
//  TopicCardView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct TopicCardView: View {
    let topic: Topic
    let onJoinConversation: () -> Void
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with category and trending badge
            HStack {
                Text(topic.category)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .foregroundColor(Color.theme(.primaryText))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.theme(.primaryAccent).opacity(0.15))
                    )
                
                Spacer()
                
                if topic.isTrending {
                    HStack(spacing: 3) {
                        Text("🔥")
                            .font(.caption2)
                        Text("trending".localized)
                            .font(.system(.caption2, design: .rounded, weight: .semibold))
                            .foregroundColor(Color.theme(.primaryText))
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(
                        Capsule()
                            .fill(Color.theme(.secondaryAccent).opacity(0.2))
                    )
                }
            }
            
            // Title
            Text(topic.title)
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundColor(Color.theme(.primaryText))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            // Description
            Text(topic.description)
                .font(.system(.callout, design: .rounded, weight: .medium))
                .foregroundColor(Color.theme(.secondaryText))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme(.cardBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.theme(.primaryAccent).opacity(themeManager.currentTheme == .dark ? 0.15 : 0.1),
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
                        .stroke(Color.theme(.border).opacity(themeManager.currentTheme == .dark ? 0.4 : 0.3), lineWidth: 1)
                )
        )
        .shadow(color: Color.theme(.shadow), radius: 15, x: 0, y: 8)
    }
}

#Preview {
    TopicCardView(topic: Topic.getDailyTopics(for: "tr")[0]) {
        print("Join conversation tapped")
    }
    .padding()
}
