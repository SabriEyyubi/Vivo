//
//  FeedbackCard.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct FeedbackCard: View {
    let icon: String
    let title: String
    let description: String
    let backgroundColor: Color
    let borderColor: Color
    let iconColor: Color
    let onTap: () -> Void
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            // Icon
            Image(systemName: icon)
                .font(.system(.title2, weight: .bold))
                .foregroundColor(iconColor)
            
            // Title
            Text(title)
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundColor(Color.theme(.primaryText))
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            // Description
            Text(description)
                .font(.system(.caption, design: .rounded, weight: .medium))
                .foregroundColor(Color.theme(.secondaryText))
                .multilineTextAlignment(.center)
                .lineLimit(3)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme(.cardBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(borderColor.opacity(0.3), lineWidth: 1)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(backgroundColor)
                )
        )
        .shadow(color: Color.theme(.shadow), radius: 8, x: 0, y: 3)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    HStack(spacing: 16) {
        FeedbackCard(
            icon: "lightbulb.fill",
            title: "Konu Öner",
            description: "Yeni konu önerisi gönder",
            backgroundColor: Color.blue.opacity(0.1),
            borderColor: Color.blue,
            iconColor: Color.blue
        ) {
            print("Topic suggestion tapped")
        }
        
        FeedbackCard(
            icon: "message.fill",
            title: "Geri Bildirim",
            description: "Görüşlerini paylaş",
            backgroundColor: Color.purple.opacity(0.1),
            borderColor: Color.purple,
            iconColor: Color.purple
        ) {
            print("Feedback tapped")
        }
    }
    .padding()
}
