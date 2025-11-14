//
//  AIView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct AIView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(content: "Merhaba! Ben Vivo AI asistanınız. Size nasıl yardımcı olabilirim?", isUser: false)
    ]
    
    var body: some View {
        ZStack {
            // Beautiful gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.theme(.gradientStart).opacity(0.2),
                    Color.theme(.gradientMiddle).opacity(0.15),
                    Color.theme(.primaryBackground)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("ai_assistant".localized)
                        .font(.system(.title2, design: .rounded, weight: .bold))
                        .foregroundColor(Color.theme(.primaryText))
                    
                    Spacer()
                    
                    // AI Avatar
                    ZStack {
                        Circle()
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
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: "brain.head.profile")
                            .font(.system(.title3, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                    }
                    .onChange(of: messages.count) { _ in
                        if let lastMessage = messages.last {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Input Area
                VStack(spacing: 0) {
                    Divider()
                        .background(Color.theme(.border))
                    
                    HStack(spacing: 12) {
                        TextField("ai_placeholder".localized, text: $messageText, axis: .vertical)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(Color.theme(.primaryText))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.theme(.cardBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.theme(.border).opacity(0.5), lineWidth: 1)
                                    )
                            )
                            .lineLimit(1...4)
                        
                        Button(action: sendMessage) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(.title2, weight: .bold))
                                .foregroundColor(messageText.isEmpty ? Color.theme(.secondaryText) : Color.theme(.primaryAccent))
                        }
                        .disabled(messageText.isEmpty)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }
                .background(Color.theme(.primaryBackground))
            }
        }
        .onReceive(localizationHelper.$currentLanguage) { _ in
            // Refresh when language changes
        }
    }
    
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(content: messageText, isUser: true)
        messages.append(userMessage)
        
        let aiResponse = ChatMessage(
            content: "Bu ilginç bir konu! Bu hakkında daha detaylı konuşabiliriz. Başka bir şey sormak ister misiniz?",
            isUser: false
        )
        
        messageText = ""
        
        // Simulate AI response delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            messages.append(aiResponse)
        }
    }
}

#Preview {
    AIView()
}
