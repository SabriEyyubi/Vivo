//
//  ZodiacRecommendationsView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct ZodiacRecommendationsView: View {
    @StateObject private var themeManager = ThemeManager.shared
    @Environment(\.presentationMode) var presentationMode
    
    let people: [PersonInfo]
    
    // Safety check for people array
    private var safePeople: [PersonInfo] {
        return people.isEmpty ? [] : people
    }
    
    // Dummy recommended topics based on zodiac signs
    private var recommendedTopics: [ZodiacTopic] {
        // Safety check to prevent crashes
        guard !safePeople.isEmpty else {
            return []
        }
        
        return [
            ZodiacTopic(
                id: 1,
                title: "zodiac_communication_style".localized,
                description: "zodiac_communication_description".localized,
                difficulty: "easy".localized,
                zodiacSigns: ["aries", "gemini", "leo"],
                isTrending: true
            ),
            ZodiacTopic(
                id: 2,
                title: "zodiac_relationship_dynamics".localized,
                description: "zodiac_relationship_description".localized,
                difficulty: "medium".localized,
                zodiacSigns: ["cancer", "scorpio", "pisces"],
                isTrending: false
            ),
            ZodiacTopic(
                id: 3,
                title: "zodiac_career_paths".localized,
                description: "zodiac_career_description".localized,
                difficulty: "medium".localized,
                zodiacSigns: ["capricorn", "virgo", "taurus"],
                isTrending: true
            ),
            ZodiacTopic(
                id: 4,
                title: "zodiac_creative_expression".localized,
                description: "zodiac_creative_description".localized,
                difficulty: "easy".localized,
                zodiacSigns: ["aquarius", "libra", "sagittarius"],
                isTrending: false
            ),
            ZodiacTopic(
                id: 5,
                title: "zodiac_emotional_intelligence".localized,
                description: "zodiac_emotional_description".localized,
                difficulty: "hard".localized,
                zodiacSigns: ["cancer", "scorpio", "pisces", "virgo"],
                isTrending: true
            )
        ]
    }
    
    var body: some View {
        ZStack {
            // Background
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.theme(.gradientStart).opacity(themeManager.currentTheme == .dark ? 0.4 : 0.3),
                    Color.theme(.gradientMiddle).opacity(themeManager.currentTheme == .dark ? 0.3 : 0.2),
                    Color.theme(.primaryBackground)
                ]),
                center: .topLeading,
                startRadius: 100,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 16) {
                        Text("✨")
                            .font(.system(size: 40))
                        
                        Text("zodiac_recommendations".localized)
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .foregroundColor(Color.theme(.primaryText))
                            .multilineTextAlignment(.center)
                        
                        Text("zodiac_recommendations_description".localized)
                            .font(.system(.body, design: .rounded, weight: .medium))
                            .foregroundColor(Color.theme(.secondaryText))
                            .opacity(themeManager.currentTheme == .dark ? 0.9 : 1.0)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    
                    // Recommended Topics
                    LazyVStack(spacing: 16) {
                        ForEach(recommendedTopics) { topic in
                            ZodiacRecommendationCard(topic: topic)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .navigationTitle("zodiac_recommendations".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ZodiacTopic: Identifiable {
    let id: Int
    let title: String
    let description: String
    let difficulty: String
    let zodiacSigns: [String]
    let isTrending: Bool
}

struct ZodiacRecommendationCard: View {
    @StateObject private var themeManager = ThemeManager.shared
    let topic: ZodiacTopic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with difficulty and trending badge
            HStack {
                Text(topic.difficulty)
                    .font(.system(.caption, design: .rounded, weight: .bold))
                    .foregroundColor(Color.theme(.primaryText))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.theme(.secondaryAccent).opacity(0.2))
                    )
                
                Spacer()
                
                if topic.isTrending {
                    HStack(spacing: 4) {
                        Text("🔥")
                            .font(.caption)
                        Text("trending".localized)
                            .font(.system(.caption, design: .rounded, weight: .semibold))
                            .foregroundColor(Color.theme(.primaryText))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.theme(.secondaryAccent).opacity(0.2))
                    )
                }
            }
            
            // Title
            Text(topic.title)
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundColor(Color.theme(.primaryText))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            // Description
            Text(topic.description)
                .font(.system(.body, design: .rounded, weight: .medium))
                .foregroundColor(Color.theme(.secondaryText))
                .opacity(themeManager.currentTheme == .dark ? 0.9 : 1.0)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            // Zodiac signs
            VStack(alignment: .leading, spacing: 8) {
                Text("zodiac_signs_included".localized)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .foregroundColor(Color.theme(.secondaryText))
                    .opacity(0.8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(topic.zodiacSigns, id: \.self) { sign in
                            Text(sign.localized)
                                .font(.system(.caption, design: .rounded, weight: .medium))
                                .foregroundColor(Color.theme(.primaryAccent))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule()
                                        .fill(Color.theme(.primaryAccent).opacity(0.1))
                                )
                        }
                    }
                    .padding(.horizontal, 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // Action button
            HStack {
                Spacer()
                Button(action: {
                    // Handle topic discussion
                    print("Start discussion for: \(topic.title)")
                }) {
                    Text("discuss".localized)
                        .font(.system(.caption, design: .rounded, weight: .semibold))
                        .foregroundColor(Color.theme(.primaryAccent))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .stroke(Color.theme(.primaryAccent), lineWidth: 1)
                        )
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme(.cardBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.theme(.primaryAccent).opacity(themeManager.currentTheme == .dark ? 0.1 : 0.05),
                                    Color.theme(.secondaryAccent).opacity(themeManager.currentTheme == .dark ? 0.05 : 0.03),
                                    Color.clear
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme(.border).opacity(themeManager.currentTheme == .dark ? 0.4 : 0.3), lineWidth: 1)
                )
        )
        .shadow(color: Color.theme(.shadow), radius: 15, x: 0, y: 8)
    }
}

#Preview {
    NavigationView {
        ZodiacRecommendationsView(people: [])
    }
}
