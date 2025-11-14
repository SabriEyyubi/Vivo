//
//  SplashScreenView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false
    @State private var showMainApp = false
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var backgroundOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            if showMainApp {
                ContentView()
                    .transition(.opacity)
            } else {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.purple.opacity(0.6),
                        Color.orange.opacity(0.4)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .opacity(backgroundOpacity)
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Logo placeholder with animation
                    VStack(spacing: 20) {
                        // Logo circle with app icon
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 120, height: 120)
                                .scaleEffect(logoScale)
                                .opacity(logoOpacity)
                            
                            // App icon placeholder
                            Image(systemName: "globe.americas.fill")
                                .font(.system(size: 50, weight: .light))
                                .foregroundColor(.white)
                                .scaleEffect(logoScale)
                                .opacity(logoOpacity)
                        }
                        
                        // App name
                        Text("Vivo")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .opacity(textOpacity)
                        
                        // Tagline
                        Text("Connect. Share. Live.")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .opacity(textOpacity)
                    }
                    
                    Spacer()
                    
                    // Loading indicator
                    VStack(spacing: 15) {
                        // Animated dots
                        HStack(spacing: 8) {
                            ForEach(0..<3) { index in
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 8, height: 8)
                                    .scaleEffect(isAnimating ? 1.2 : 0.8)
                                    .opacity(isAnimating ? 1.0 : 0.5)
                                    .animation(
                                        .easeInOut(duration: 0.6)
                                        .repeatForever()
                                        .delay(Double(index) * 0.2),
                                        value: isAnimating
                                    )
                            }
                        }
                        
                        Text("Loading...")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .opacity(textOpacity)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Start background fade in
        withAnimation(.easeInOut(duration: 0.8)) {
            backgroundOpacity = 1.0
        }
        
        // Logo scale and fade in
        withAnimation(.easeOut(duration: 1.0).delay(0.3)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }
        
        // Text fade in
        withAnimation(.easeInOut(duration: 0.8).delay(0.8)) {
            textOpacity = 1.0
        }
        
        // Start loading animation
        withAnimation(.easeInOut(duration: 0.6).delay(1.2)) {
            isAnimating = true
        }
        
        // Transition to main app
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeInOut(duration: 0.8)) {
                showMainApp = true
            }
        }
    }
}

// MARK: - Alternative Splash Screen with Custom Logo
struct SplashScreenWithCustomLogo: View {
    @State private var isAnimating = false
    @State private var showMainApp = false
    @State private var logoScale: CGFloat = 0.3
    @State private var logoRotation: Double = 0
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var backgroundOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            if showMainApp {
                ContentView()
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .scale(scale: 1.1)),
                        removal: .opacity.combined(with: .scale(scale: 0.9))
                    ))
            } else {
                // Animated background
                ZStack {
                    // Base gradient
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(0.9),
                            Color.purple.opacity(0.7),
                            Color.pink.opacity(0.5)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    // Floating circles
                    ForEach(0..<5) { index in
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: CGFloat.random(in: 50...150))
                            .position(
                                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                            )
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .opacity(isAnimating ? 0.3 : 0.1)
                            .animation(
                                .easeInOut(duration: 2.0)
                                .repeatForever()
                                .delay(Double(index) * 0.3),
                                value: isAnimating
                            )
                    }
                }
                .ignoresSafeArea()
                .opacity(backgroundOpacity)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Custom logo area
                    VStack(spacing: 25) {
                        // Logo container
                        ZStack {
                            // Background circle
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.white.opacity(0.3),
                                            Color.white.opacity(0.1)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 140, height: 140)
                                .scaleEffect(logoScale)
                                .opacity(logoOpacity)
                            
                            // Logo placeholder - replace with your actual logo
                            VStack(spacing: 8) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 40, weight: .light))
                                    .foregroundColor(.white)
                                
                                Text("V")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .scaleEffect(logoScale)
                            .opacity(logoOpacity)
                            .rotationEffect(.degrees(logoRotation))
                        }
                        
                        // App branding
                        VStack(spacing: 8) {
                            Text("Vivo")
                                .font(.system(size: 42, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .opacity(textOpacity)
                            
                            Text("Your Social Experience")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .opacity(textOpacity)
                        }
                    }
                    
                    Spacer()
                    
                    // Loading section
                    VStack(spacing: 20) {
                        // Modern loading indicator
                        ZStack {
                            Circle()
                                .stroke(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 40, height: 40)
                            
                            Circle()
                                .trim(from: 0, to: 0.7)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.white, Color.white.opacity(0.5)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                                )
                                .frame(width: 40, height: 40)
                                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                                .animation(
                                    .linear(duration: 1.0)
                                    .repeatForever(autoreverses: false),
                                    value: isAnimating
                                )
                        }
                        
                        Text("Initializing...")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .opacity(textOpacity)
                    }
                    .padding(.bottom, 60)
                }
            }
        }
        .onAppear {
            startCustomAnimations()
        }
    }
    
    private func startCustomAnimations() {
        // Background fade in
        withAnimation(.easeInOut(duration: 1.0)) {
            backgroundOpacity = 1.0
        }
        
        // Logo animations
        withAnimation(.easeOut(duration: 1.2).delay(0.5)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }
        
        withAnimation(.easeInOut(duration: 2.0).delay(1.0)) {
            logoRotation = 360
        }
        
        // Text fade in
        withAnimation(.easeInOut(duration: 1.0).delay(1.2)) {
            textOpacity = 1.0
        }
        
        // Start loading animation
        withAnimation(.easeInOut(duration: 0.8).delay(1.5)) {
            isAnimating = true
        }
        
        // Transition to main app
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeInOut(duration: 1.0)) {
                showMainApp = true
            }
        }
    }
}

#Preview {
    SplashScreenView()
}

#Preview("Custom Logo Version") {
    SplashScreenWithCustomLogo()
}
