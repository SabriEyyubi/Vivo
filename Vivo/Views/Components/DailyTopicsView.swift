import SwiftUI
import RealmSwift

struct DailyTopicsView: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @State private var dailyTopics: [Topic] = []
    @State private var hotTopics: [TopicRealm] = []
    @State private var suggestedTopics: [TopicRealm] = []
    let onTabChange: (Int) -> Void
    
    private let categoryKeyByName: [String: String] = [
        "Teknoloji": "technology",
        "Sosyal": "social",
        "Bilim": "science",
        "Sanat": "art",
        "Spor": "sport",
        "Müzik": "music",
        "Film": "film",
        "Kitap": "book",
        "Yemek": "food",
        "Seyahat": "travel",
        "Moda": "fashion",
        "Sağlık": "health",
        "Eğitim": "education",
        "Çevre": "environment",
        "İş Hayatı": "work_life"
    ]

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
                        ForEach(Array(dailyTopics.enumerated()), id: \.element.id) { index, topic in
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
                        ForEach(hotTopics.indices, id: \.self) { hotIndex in
                            let topic = hotTopics[hotIndex]
                            HotTopicCard(
                                title: topic.title,
                                description: topic.summary,
                                difficulty: ["easy", "medium", "hard"].randomElement()?.localized ?? "medium".localized
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
                        ForEach(suggestedTopics.indices, id: \.self) { suggestionIndex in
                            let topic = suggestedTopics[suggestionIndex]
                            TopicSuggestionCard(
                                title: topic.title,
                                description: topic.summary,
                                category: localizedCategoryName(topic.category)
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
            loadRandomTopics()
        }
        .onAppear {
            loadRandomTopics()
        }
    }

    private func loadRandomTopics() {
        do {
            let realm = try Realm()
            let results = realm.objects(TopicRealm.self)
                .where { $0.language == localizationHelper.currentLanguage.rawValue }
            let all = Array(results).shuffled()

            let daily = Array(all.prefix(10))
            let hot = Array(all.dropFirst(10).prefix(10))
            let suggested = Array(all.dropFirst(20).prefix(10))

            dailyTopics = daily.map { topic in
                Topic(
                    title: topic.title,
                    description: topic.summary,
                    category: localizedCategoryName(topic.category),
                    difficulty: .medium,
                    language: localizationHelper.currentLanguage.rawValue
                )
            }

            hotTopics = hot
            suggestedTopics = suggested
        } catch {
            dailyTopics = []
            hotTopics = []
            suggestedTopics = []
        }
    }

    private func localizedCategoryName(_ category: String) -> String {
        let key = categoryKeyByName[category] ?? category
        return key.localized
    }
}
