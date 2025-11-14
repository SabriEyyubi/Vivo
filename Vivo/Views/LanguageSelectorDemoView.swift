//
//  LanguageSelectorDemoView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct LanguageSelectorDemoView: View {
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Main content
            VStack(spacing: 30) {
                Text("Language Selector Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    Text("Current Language:")
                        .font(.headline)
                    
                    Text(LocalizationHelper.shared.currentLanguage.displayName)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Sample Localized Text:")
                        .font(.headline)
                    
                    Group {
                        Text("app_name: \("app_name".localized)")
                        Text("welcome: \("welcome".localized)")
                        Text("hello: \("hello".localized)")
                        Text("language: \("language".localized)")
                        Text("settings: \("settings".localized)")
                    }
                    .font(.body)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Available Styles:")
                        .font(.headline)
                    
                    HStack(spacing: 15) {
                        Text("Compact")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("Full")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("Minimal")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                
                Spacer()
            }
            .padding()
            
            // Language selectors in all corners
            LanguageSelectorButton(position: .topLeading, style: .minimal)
            LanguageSelectorButton(position: .topTrailing, style: .compact)
            LanguageSelectorButton(position: .bottomLeading, style: .full)
            LanguageSelectorButton(position: .bottomTrailing, style: .compact)
        }
    }
}

#Preview {
    LanguageSelectorDemoView()
}
