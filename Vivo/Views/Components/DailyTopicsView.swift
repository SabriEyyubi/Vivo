import SwiftUI

struct DailyTopicsView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    let onTabChange: (Int) -> Void
    
    private var topics: [Topic] {
        Topic.getDailyTopics(for: localizationHelper.currentLanguage.rawValue)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {

            // MARK: - Daily Topics Section
            VStack(alignment: .center, spacing: 24) {
                // MARK: - Header
                Text("daily_topics".localized)
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.theme(.primaryText),
                                Color.theme(.primaryText).opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Array(topics.enumerated()), id: \.element.id) { index, topic in
                            TopicCardView(topic: topic) { }
                                .frame(width: 300)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.top, 12)
            
            // MARK: - Hot Topics Section
            VStack(alignment: .center, spacing: 16) {
                Text("hot_topics".localized)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.theme(.primaryText),
                                Color.theme(.primaryText).opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        // Hot topics cards
                        ForEach(0..<3) { hotIndex in
                            HotTopicCard(
                                title: "Hot Topics \(hotIndex + 1)",
                                description: "hot_topic_description".localized,
                                difficulty: "difficult".localized
                            )
                            .frame(width: 280)
                        }
                        
                        // More explore card
                        MoreExploreCard {
                            onTabChange(3) // AI tab index
                        }
                        .frame(width: 280)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.top, 24)
            
            // MARK: - Topic Suggestions Section
            VStack(alignment: .center, spacing: 16) {
                Text("topic_suggestions".localized)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.theme(.primaryText),
                                Color.theme(.primaryText).opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        // Suggestion cards
                        ForEach(0..<5) { suggestionIndex in
                            TopicSuggestionCard(
                                title: "Önerilen Konu \(suggestionIndex + 1)",
                                description: "Bu konu size özel olarak öneriliyor",
                                category: suggestionIndex % 2 == 0 ? "Teknoloji" : "Sosyal"
                            )
                            .frame(width: 260)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.top, 24)
            
            // MARK: - Feedback Section
            VStack(alignment: .center, spacing: 16) {
                Text("feedback_section".localized)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.theme(.primaryText),
                                Color.theme(.primaryText).opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                
                HStack(spacing: 16) {
                    // Topic Suggestion Button
                    FeedbackCard(
                        icon: "lightbulb.fill",
                        title: "suggest_topic".localized,
                        description: "suggest_topic_description".localized,
                        backgroundColor: Color.theme(.primaryAccent).opacity(0.1),
                        borderColor: Color.theme(.primaryAccent),
                        iconColor: Color.theme(.primaryAccent)
                    ) {
                        // Handle topic suggestion
                        print("Topic suggestion tapped")
                    }
                    
                    // Feedback Button
                    FeedbackCard(
                        icon: "message.fill",
                        title: "send_feedback".localized,
                        description: "send_feedback_description".localized,
                        backgroundColor: Color.theme(.secondaryAccent).opacity(0.1),
                        borderColor: Color.theme(.secondaryAccent),
                        iconColor: Color.theme(.secondaryAccent)
                    ) {
                        // Handle feedback
                        print("Feedback tapped")
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 24)
            .padding(.bottom, 20)
            }
        }
        .onReceive(localizationHelper.$currentLanguage) { _ in
            // Language changed, no need to reset index since we're not using TabView anymore
        }
    }
}
