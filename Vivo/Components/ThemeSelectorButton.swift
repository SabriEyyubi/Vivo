//
//  ThemeSelectorButton.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct ThemeSelectorButton: View {
    @StateObject private var themeManager = ThemeManager.shared
    @State private var showingThemeMenu = false
    @State private var refreshID = UUID()
    
    let position: Position
    
    enum Position {
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }
    
    init(position: Position = .topLeading) {
        self.position = position
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Main button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showingThemeMenu.toggle()
                }
            }) {
                HStack(spacing: 6) {
                    Image(systemName: themeManager.currentTheme.icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.theme(.primaryAccent))
                    
                    Text(themeManager.currentTheme.displayName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.theme(.primaryText))
                    
                    Image(systemName: showingThemeMenu ? "chevron.up" : "chevron.down")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color.theme(.secondaryText))
                        .rotationEffect(.degrees(showingThemeMenu ? 180 : 0))
                        .animation(.easeInOut(duration: 0.2), value: showingThemeMenu)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.theme(.cardBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.theme(.border), lineWidth: 1)
                        )
                        .shadow(color: Color.theme(.shadow), radius: 2, x: 0, y: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            // Dropdown menu
            if showingThemeMenu {
                VStack(spacing: 0) {
                    ForEach(AppTheme.allCases) { theme in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.15)) {
                                themeManager.setTheme(theme)
                                showingThemeMenu = false
                                refreshID = UUID()
                            }
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: theme.icon)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.theme(.primaryAccent))
                                    .frame(width: 16)
                                
                                Text(theme.displayName)
                                    .font(.system(size: 13, weight: theme == themeManager.currentTheme ? .semibold : .medium))
                                    .foregroundColor(Color.theme(.primaryText))
                                
                                if theme == themeManager.currentTheme {
                                    Spacer()
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.theme(.primaryAccent))
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(theme == themeManager.currentTheme ? Color.theme(.primaryAccent).opacity(0.1) : Color.clear)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if theme != AppTheme.allCases.last {
                            Divider()
                                .padding(.horizontal, 12)
                        }
                    }
                }
                .frame(maxWidth: 100)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.theme(.cardBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.theme(.border), lineWidth: 1)
                        )
                        .shadow(color: Color.theme(.shadow), radius: 4, x: 0, y: 2)
                )
                .padding(.top, 4)
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .scale(scale: 0.95, anchor: .top)),
                    removal: .opacity.combined(with: .scale(scale: 0.95, anchor: .top))
                ))
            }
        }
        .id(refreshID)
        .positioned(in: position)
    }
}

// MARK: - Positioned Modifier
extension View {
    func positioned(in position: ThemeSelectorButton.Position) -> some View {
        self.modifier(ThemePositionedModifier(position: position))
    }
}

struct ThemePositionedModifier: ViewModifier {
    let position: ThemeSelectorButton.Position
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .position(
                    x: position == .topLeading || position == .bottomLeading ? 60 : geometry.size.width - 60,
                    y: position == .topLeading || position == .topTrailing ? 60 : geometry.size.height - 60
                )
        }
    }
}


