//
//  DiscoverView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var showingZodiacInput = false
    
    var body: some View {
        ZStack {
            // Beautiful gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.theme(.gradientEnd).opacity(0.2),
                    Color.theme(.gradientStart).opacity(0.1),
                    Color.theme(.primaryBackground)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    // Zodiac Topics Card
                    VStack(spacing: 20) {
                        Text("Featured Discovery")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundColor(Color.theme(.primaryText))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        
                        ZodiacTopicCard {
                            showingZodiacInput = true
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Additional discovery options
                    VStack(spacing: 20) {
                        Text("More Ways to Discover")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundColor(Color.theme(.primaryText))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        
                        // Placeholder for more discovery options
                        VStack(spacing: 16) {
                            ForEach(0..<3) { index in
                                HStack {
                                    Image(systemName: "sparkles")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color.theme(.primaryAccent))
                                    
                                    Text("Discovery Option \(index + 1)")
                                        .font(.system(.body, design: .rounded, weight: .medium))
                                        .foregroundColor(Color.theme(.primaryText))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color.theme(.secondaryText))
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.theme(.cardBackground))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.theme(.border).opacity(0.3), lineWidth: 1)
                                        )
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .navigationDestination(isPresented: $showingZodiacInput) {
            ZodiacInputView()
        }
        .onReceive(localizationHelper.$currentLanguage) { _ in
            // Refresh when language changes
        }
    }
}
