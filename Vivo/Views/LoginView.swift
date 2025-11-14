//
//  LoginView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @StateObject private var themeManager = ThemeManager.shared
    @State private var isLoading = false
    let onLoginSuccess: () -> Void
    
    var body: some View {
        ZStack {
            // Beautiful gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.theme(.gradientStart),
                    Color.theme(.gradientMiddle),
                    Color.theme(.gradientEnd)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Subtle overlay for better text readability
            Color.theme(.primaryBackground)
                .opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with logo and welcome text
                VStack(spacing: 20) {
                    Spacer()
                    
                    // Logo placeholder
                    VStack(spacing: 16) {
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
                                .frame(width: 80, height: 80)
                            
                            Text("V")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .shadow(color: Color.theme(.primaryAccent).opacity(0.4), radius: 15, x: 0, y: 8)
                        
                        VStack(spacing: 8) {
                            Text("welcome_back".localized)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme(.primaryText))
                            
                            Text("login_subtitle".localized)
                                .font(.subheadline)
                                .foregroundColor(Color.theme(.secondaryText))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                    }
                    
                    Spacer()
                }
                
                // Login buttons section
                VStack(spacing: 16) {
                    // Apple Login Button
                    LoginButton(
                        title: "login_with_apple".localized,
                        icon: "applelogo",
                        backgroundColor: Color.black,
                        foregroundColor: .white,
                        isLoading: isLoading
                    ) {
                        handleAppleLogin()
                    }
                    
                    // Google Login Button
                    LoginButton(
                        title: "login_with_google".localized,
                        icon: "globe",
                        backgroundColor: Color.theme(.cardBackground),
                        foregroundColor: Color.theme(.primaryText),
                        isLoading: isLoading
                    ) {
                        handleGoogleLogin()
                    }
                    
                    // Divider
                    HStack {
                        Rectangle()
                            .fill(Color.theme(.border))
                            .frame(height: 1)
                        
                        Text("or".localized)
                            .font(.caption)
                            .foregroundColor(Color.theme(.secondaryText))
                            .padding(.horizontal, 16)
                        
                        Rectangle()
                            .fill(Color.theme(.border))
                            .frame(height: 1)
                    }
                    .padding(.vertical, 20)
                    
                    // Continue without login button
                    Button(action: handleContinueWithoutLogin) {
                        Text("continue_without_login".localized)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme(.primaryAccent))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.theme(.primaryAccent).opacity(0.1))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.theme(.primaryAccent), lineWidth: 2)
                            )
                    }
                    .disabled(isLoading)
                    
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
            
            // Language selector in top-right corner
            LanguageSelectorButton(position: .topTrailing, style: .compact)
            
            // Theme selector in top-left corner
            ThemeSelectorButton(position: .topLeading)
        }
    }
    
    // MARK: - Actions
    private func handleAppleLogin() {
        isLoading = true
        // Simulate Apple login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            onLoginSuccess()
        }
    }
    
    private func handleGoogleLogin() {
        isLoading = true
        // Simulate Google login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            onLoginSuccess()
        }
    }
    
    private func handleContinueWithoutLogin() {
        onLoginSuccess()
    }
}

struct LoginButton: View {
    let title: String
    let icon: String
    let backgroundColor: Color
    let foregroundColor: Color
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(foregroundColor)
                }
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(foregroundColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(backgroundColor)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.theme(.border), lineWidth: 1)
            )
        }
        .disabled(isLoading)
    }
}

#Preview {
    LoginView {
        print("Login successful")
    }
}
