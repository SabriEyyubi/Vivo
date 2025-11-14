//
//  MoreExploreCard.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct MoreExploreCard: View {
    @StateObject private var themeManager = ThemeManager.shared
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with AI icon
            HStack {
                Text("AI")
                    .font(.system(.caption, design: .rounded, weight: .bold))
                    .foregroundColor(Color.theme(.primaryText))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.theme(.primaryAccent).opacity(0.15))
                    )
                
                Spacer()
                
                // AI icon
                Image(systemName: "brain.head.profile")
                    .font(.title3)
                    .foregroundColor(Color.theme(.primaryAccent))
            }
            
            // Title
            Text("more_explore".localized)
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundColor(Color.theme(.primaryText))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            // Description
            Text("more_explore_description".localized)
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
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.theme(.border).opacity(themeManager.currentTheme == .dark ? 0.4 : 0.3), lineWidth: 1)
                )
        )
        .shadow(color: Color.theme(.shadow), radius: 10, x: 0, y: 4)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    MoreExploreCard {
        print("More explore tapped")
    }
    .padding()
}
