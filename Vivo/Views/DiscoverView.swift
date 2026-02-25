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
