//
//  CategoryTopicsView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct CategoryTopicsView: View {
    let category: Category
    @StateObject private var themeManager = ThemeManager.shared
    
    // Dummy topics for the category
    private var categoryTopics: [CategoryTopic] {
        generateTopicsForCategory(category)
    }
    
    var body: some View {
        ZStack {
            // Background (same as other views)
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
            
            // Additional subtle gradient overlay
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.theme(.gradientEnd).opacity(themeManager.currentTheme == .dark ? 0.15 : 0.1),
                    Color.clear,
                    Color.theme(.gradientStart).opacity(themeManager.currentTheme == .dark ? 0.15 : 0.1)
                ]),
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(categoryTopics) { topic in
                        CategoryTopicCard(topic: topic)
                            .padding(.horizontal, 20)
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func generateTopicsForCategory(_ category: Category) -> [CategoryTopic] {
        let topicTitles = [
            "technology": ["ai_future", "blockchain_technology", "quantum_computers", "iot_smart_homes", "5g_technology", "cybersecurity", "robotics_automation"],
            "social": ["social_media_impact", "digital_detox", "online_communication", "social_anxiety", "friendship_relationships", "social_change", "cultural_diversity"],
            "science": ["climate_change", "space_exploration", "genetic_engineering", "nanotechnology", "biodiversity", "physics_laws", "chemistry_life"],
            "art": ["digital_art", "modern_painting", "sculpture_art", "photography", "graphic_design", "art_therapy", "cultural_heritage"],
            "sport": ["football_world", "olympics", "sports_psychology", "training_science", "sports_nutrition", "injury_prevention", "sports_technology"]
        ]
        
        // Map category names to localization keys
        let categoryKey = category.name.lowercased()
        let titles = topicTitles[categoryKey] ?? ["general_topic", "general_topic", "general_topic", "general_topic", "general_topic"]
        
        return titles.enumerated().map { index, titleKey in
            CategoryTopic(
                id: index + 1,
                title: titleKey.localized,
                description: "topic_description_template".localized(with: category.name.lowercased()),
                difficulty: ["easy", "medium", "hard"].randomElement()?.localized ?? "medium".localized,
                isTrending: Bool.random()
            )
        }
    }
}

struct CategoryTopic: Identifiable {
    let id: Int
    let title: String
    let description: String
    let difficulty: String
    let isTrending: Bool
}

struct CategoryTopicCard: View {
    let topic: CategoryTopic
    @StateObject private var themeManager = ThemeManager.shared
    
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
    CategoryTopicsView(category: Category(id: 1, name: "Teknoloji", icon: "laptopcomputer", topicCount: 25))
}
