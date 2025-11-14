//
//  SettingRow.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct SettingRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.theme(.primaryAccent).opacity(0.15))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: icon)
                        .font(.system(.title3, weight: .bold))
                        .foregroundColor(Color.theme(.primaryAccent))
                }
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(.headline, design: .rounded, weight: .bold))
                        .foregroundColor(Color.theme(.primaryText))
                    
                    Text(subtitle)
                        .font(.system(.body, design: .rounded, weight: .medium))
                        .foregroundColor(Color.theme(.secondaryText))
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.system(.body, weight: .bold))
                    .foregroundColor(Color.theme(.secondaryText))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.theme(.cardBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.theme(.border).opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 12) {
        SettingRow(
            icon: "sun.max.fill",
            title: "Theme",
            subtitle: "Light Mode"
        ) {
            print("Theme tapped")
        }
        
        SettingRow(
            icon: "globe",
            title: "Language",
            subtitle: "Türkçe"
        ) {
            print("Language tapped")
        }
    }
    .padding()
}
