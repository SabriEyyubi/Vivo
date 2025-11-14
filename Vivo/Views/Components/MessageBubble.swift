//
//  MessageBubble.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.theme(.primaryAccent),
                                            Color.theme(.secondaryAccent)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(.caption2, design: .rounded))
                        .foregroundColor(Color.theme(.secondaryText))
                        .padding(.trailing, 4)
                }
                .frame(maxWidth: .infinity * 0.75, alignment: .trailing)
            } else {
                HStack(alignment: .top, spacing: 8) {
                    // AI Avatar
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.theme(.primaryAccent).opacity(0.2),
                                        Color.theme(.secondaryAccent).opacity(0.2)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 32, height: 32)
                        
                        Image(systemName: "brain.head.profile")
                            .font(.system(.caption, weight: .bold))
                            .foregroundColor(Color.theme(.primaryAccent))
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.content)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(Color.theme(.primaryText))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color.theme(.cardBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(Color.theme(.border).opacity(0.3), lineWidth: 1)
                                    )
                            )
                        
                        Text(formatTime(message.timestamp))
                            .font(.system(.caption2, design: .rounded))
                            .foregroundColor(Color.theme(.secondaryText))
                            .padding(.leading, 4)
                    }
                }
                .frame(maxWidth: .infinity * 0.75, alignment: .leading)
                
                Spacer()
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    VStack(spacing: 12) {
        MessageBubble(message: ChatMessage(content: "Merhaba! Size nasıl yardımcı olabilirim?", isUser: false))
        MessageBubble(message: ChatMessage(content: "Yapay zeka hakkında konuşmak istiyorum", isUser: true))
    }
    .padding()
}
