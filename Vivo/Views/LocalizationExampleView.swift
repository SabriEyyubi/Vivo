//
//  LocalizationExampleView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct LocalizationExampleView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @State private var refreshID = UUID()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // App Title
                Text("app_name".localized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Welcome Message
                Text("welcome".localized)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                // Language Selection
                VStack(alignment: .leading, spacing: 10) {
                    Text("language".localized)
                        .font(.headline)
                    
                    Picker("language".localized, selection: $localizationHelper.currentLanguage) {
                        ForEach(Language.allCases) { language in
                            HStack {
                                Text(language.flag)
                                Text(language.displayName)
                            }
                            .tag(language)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: localizationHelper.currentLanguage) { newLanguage in
                        localizationHelper.setLanguage(newLanguage)
                        refreshID = UUID() // Force view refresh
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Sample Localized Text
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sample Localized Text:")
                        .font(.headline)
                    
                    Group {
                        Text("hello".localized)
                        Text("email".localized)
                        Text("password".localized)
                        Text("home".localized)
                        Text("search".localized)
                        Text("profile".localized)
                    }
                    .font(.body)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Time Example
                VStack(alignment: .leading, spacing: 8) {
                    Text("Time Examples:")
                        .font(.headline)
                    
                    Group {
                        Text(TimeFormatter.timeAgo(from: Date()))
                        Text(TimeFormatter.timeAgo(from: Date().addingTimeInterval(-300))) // 5 minutes ago
                        Text(TimeFormatter.timeAgo(from: Date().addingTimeInterval(-3600))) // 1 hour ago
                        Text(TimeFormatter.timeAgo(from: Date().addingTimeInterval(-86400))) // 1 day ago
                    }
                    .font(.body)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Language Test Buttons
                VStack(spacing: 10) {
                    Text("Test Language Switching:")
                        .font(.headline)
                    
                    HStack(spacing: 10) {
                        Button("🇺🇸 English") {
                            localizationHelper.setLanguage(.english)
                            refreshID = UUID()
                        }
                        .buttonStyle(.bordered)
                        
                        Button("🇹🇷 Türkçe") {
                            localizationHelper.setLanguage(.turkish)
                            refreshID = UUID()
                        }
                        .buttonStyle(.bordered)
                        
                        Button("🇪🇸 Español") {
                            localizationHelper.setLanguage(.spanish)
                            refreshID = UUID()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Localization Demo")
            .id(refreshID) // Force view refresh when language changes
        }
    }
}

#Preview {
    LocalizationExampleView()
}
