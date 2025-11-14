//
//  LanguageTestView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct LanguageTestView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Language Test")
                .font(.title)
                .fontWeight(.bold)
            
            // Current Language Display
            Text("Current Language: \(localizationHelper.currentLanguage.displayName)")
                .font(.headline)
                .foregroundColor(.blue)
            
            // Test Strings
            VStack(alignment: .leading, spacing: 10) {
                Text("Test Strings:")
                    .font(.headline)
                
                Group {
                    Text("app_name: \("app_name".localized)")
                    Text("welcome: \("welcome".localized)")
                    Text("hello: \("hello".localized)")
                    Text("language: \("language".localized)")
                }
                .font(.body)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // Language Buttons
            VStack(spacing: 10) {
                Text("Switch Language:")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    Button("🇺🇸 English") {
                        localizationHelper.setLanguage(.english)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("🇹🇷 Türkçe") {
                        localizationHelper.setLanguage(.turkish)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("🇪🇸 Español") {
                        localizationHelper.setLanguage(.spanish)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LanguageTestView()
}
