//
//  FavoritesView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var themeManager = ThemeManager.shared
    
    // Dummy favorites data
    private let favoriteTopics = [
        FavoriteTopic(id: 1, title: "Yapay Zeka ve İnsanlık", description: "AI teknolojisinin gelecekte insanlığı nasıl etkileyeceği hakkında derinlemesine tartışma", category: "Teknoloji", difficulty: "Zor", isTrending: true),
        FavoriteTopic(id: 2, title: "Sosyal Medya Etkisi", description: "Sosyal medyanın gençler üzerindeki pozitif ve negatif etkilerini değerlendirelim", category: "Sosyal", difficulty: "Orta", isTrending: false),
        FavoriteTopic(id: 3, title: "Sürdürülebilir Yaşam", description: "Çevre dostu yaşam tarzları ve sürdürülebilir gelecek için alabileceğimiz önlemler", category: "Çevre", difficulty: "Kolay", isTrending: true),
        FavoriteTopic(id: 4, title: "Uzaktan Çalışma", description: "Pandemi sonrası uzaktan çalışma modelinin iş hayatına etkileri ve geleceği", category: "İş Hayatı", difficulty: "Orta", isTrending: false),
        FavoriteTopic(id: 5, title: "Eğitimde Teknoloji", description: "Dijital çağda eğitim sistemlerinin dönüşümü ve online öğrenmenin avantajları", category: "Eğitim", difficulty: "Kolay", isTrending: true)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.theme(.gradientStart).opacity(0.2),
                        Color.theme(.gradientMiddle).opacity(0.15),
                        Color.theme(.primaryBackground)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(favoriteTopics) { topic in
                            FavoriteTopicDetailCard(topic: topic)
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("favorites".localized)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done".localized) {
                        dismiss()
                    }
                    .font(.system(.body, design: .rounded, weight: .semibold))
                    .foregroundColor(Color.theme(.primaryAccent))
                }
            }
        }
    }
}

struct FavoriteTopic: Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let difficulty: String
    let isTrending: Bool
}

struct FavoriteTopicDetailCard: View {
    let topic: FavoriteTopic
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with category and trending badge
            HStack {
                Text(topic.category)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .foregroundColor(Color.theme(.primaryText))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.theme(.primaryAccent).opacity(0.15))
                    )
                
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
                
                Spacer()
                
                // Heart icon
                Image(systemName: "heart.fill")
                    .font(.title3)
                    .foregroundColor(.red)
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
                .lineLimit(4)
                .multilineTextAlignment(.leading)
            
            // Difficulty and action button
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
                
                Button(action: {
                    // Handle topic discussion
                    print("Start discussion for: \(topic.title)")
                }) {
                    Text("tartış")
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

