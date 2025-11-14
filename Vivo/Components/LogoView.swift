//
//  LogoView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct LogoView: View {
    let size: CGFloat
    let showText: Bool
    let animated: Bool
    
    @State private var isAnimating = false
    
    init(size: CGFloat = 100, showText: Bool = true, animated: Bool = true) {
        self.size = size
        self.showText = showText
        self.animated = animated
    }
    
    var body: some View {
        VStack(spacing: 12) {
            // Logo container
            ZStack {
                // Background circle
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue.opacity(0.8),
                                Color.purple.opacity(0.6)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .scaleEffect(animated && isAnimating ? 1.05 : 1.0)
                    .opacity(animated && isAnimating ? 0.9 : 1.0)
                
                // Logo placeholder - Replace this with your actual logo
                VStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: size * 0.3, weight: .light))
                        .foregroundColor(.white)
                        .scaleEffect(animated && isAnimating ? 1.1 : 1.0)
                    
                    Text("V")
                        .font(.system(size: size * 0.2, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                .rotationEffect(.degrees(animated && isAnimating ? 5 : 0))
            }
            .animation(
                .easeInOut(duration: 2.0)
                .repeatForever(autoreverses: true),
                value: isAnimating
            )
            
            // App name
            if showText {
                Text("Vivo")
                    .font(.system(size: size * 0.25, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .opacity(animated && isAnimating ? 0.8 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            if animated {
                isAnimating = true
            }
        }
    }
}

// MARK: - Logo Replacement Instructions
/*
 TO REPLACE THE LOGO:
 
 1. Add your logo image to Assets.xcassets
 2. Replace the VStack content in LogoView with:
 
 Image("your-logo-name")
     .resizable()
     .aspectRatio(contentMode: .fit)
     .frame(width: size * 0.6, height: size * 0.6)
     .foregroundColor(.white)
 
 3. Adjust the frame size as needed for your logo
 4. Remove the heart icon and "V" text
 */

#Preview {
    VStack(spacing: 30) {
        LogoView(size: 80, showText: true, animated: true)
        LogoView(size: 120, showText: false, animated: true)
        LogoView(size: 60, showText: true, animated: false)
    }
    .padding()
}
