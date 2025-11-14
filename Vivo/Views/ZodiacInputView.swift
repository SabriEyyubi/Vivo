//
//  ZodiacInputView.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

struct ZodiacInputView: View {
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @Environment(\.presentationMode) var presentationMode
    
    @State private var numberOfPeople: Int = 1
    @State private var people: [PersonInfo] = []
    @State private var currentStep: Int = 0
    @State private var showingRecommendations = false
    
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
                        Text("enter_zodiac_info".localized)
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .foregroundColor(Color.theme(.primaryText))
                            .multilineTextAlignment(.center)
                        
                        Text("zodiac_topics_description".localized)
                            .font(.system(.body, design: .rounded, weight: .medium))
                            .foregroundColor(Color.theme(.secondaryText))
                            .opacity(themeManager.currentTheme == .dark ? 0.9 : 1.0)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    if currentStep == 0 {
                        // Step 1: Number of people
                        VStack(spacing: 20) {
                            Text("how_many_people".localized)
                                .font(.system(.title2, design: .rounded, weight: .semibold))
                                .foregroundColor(Color.theme(.primaryText))
                            
                            HStack(spacing: 20) {
                                Button(action: {
                                    if numberOfPeople > 1 {
                                        numberOfPeople -= 1
                                    }
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(Color.theme(.primaryAccent))
                                }
                                .disabled(numberOfPeople <= 1)
                                
                                Text("\(numberOfPeople)")
                                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                    .foregroundColor(Color.theme(.primaryText))
                                    .frame(minWidth: 60)
                                
                                Button(action: {
                                    if numberOfPeople < 10 {
                                        numberOfPeople += 1
                                    }
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(Color.theme(.primaryAccent))
                                }
                                .disabled(numberOfPeople >= 10)
                            }
                            
                            Text("person_info".localized)
                                .font(.system(.caption, design: .rounded, weight: .medium))
                                .foregroundColor(Color.theme(.secondaryText))
                                .opacity(0.8)
                        }
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.theme(.cardBackground))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.theme(.border).opacity(0.3), lineWidth: 1)
                                )
                        )
                        .shadow(color: Color.theme(.shadow), radius: 10, x: 0, y: 5)
                    } else {
                        // Step 2: Person details
                        VStack(spacing: 20) {
                            Text("person_info".localized)
                                .font(.system(.title2, design: .rounded, weight: .semibold))
                                .foregroundColor(Color.theme(.primaryText))
                            
                            ForEach(0..<numberOfPeople, id: \.self) { index in
                                PersonInfoCard(
                                    personIndex: index + 1,
                                    person: $people[index]
                                )
                            }
                        }
                    }
                    
                    // Continue/Get Recommendations Button
                    Button(action: {
                        if currentStep == 0 {
                            // Initialize people array
                            people = Array(0..<numberOfPeople).map { _ in PersonInfo() }
                            currentStep = 1
                        } else {
                            // Get recommendations
                            getRecommendations()
                        }
                    }) {
                        HStack {
                            Text(currentStep == 0 ? "continue".localized : "get_recommendations".localized)
                                .font(.system(.headline, design: .rounded, weight: .semibold))
                                .foregroundColor(.white)
                            
                            if currentStep == 1 {
                                Image(systemName: "sparkles")
                                    .font(.system(.headline, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.theme(.primaryAccent),
                                    Color.theme(.secondaryAccent)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    .disabled(currentStep == 1 && !isFormValid)
                    .opacity(currentStep == 1 && !isFormValid ? 0.6 : 1.0)
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("zodiac_topics".localized)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showingRecommendations) {
            ZodiacRecommendationsView(people: people)
        }
    }
    
    private var isFormValid: Bool {
        people.allSatisfy { person in
            !person.gender.isEmpty && person.age > 0 && !person.zodiacSign.isEmpty
        }
    }
    
    private func getRecommendations() {
        showingRecommendations = true
    }
}

struct PersonInfo: Identifiable {
    let id = UUID()
    var gender: String = ""
    var age: Int = 0
    var zodiacSign: String = ""
}

struct PersonInfoCard: View {
    @StateObject private var themeManager = ThemeManager.shared
    let personIndex: Int
    @Binding var person: PersonInfo
    
    private let genders = ["male", "female", "other"]
    private let zodiacSigns = ["aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Person Info \(personIndex)")
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .foregroundColor(Color.theme(.primaryText))
            
            // Gender Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("gender".localized)
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundColor(Color.theme(.secondaryText))
                
                HStack(spacing: 12) {
                    ForEach(genders, id: \.self) { gender in
                        Button(action: {
                            person.gender = gender
                        }) {
                            Text(gender.localized)
                                .font(.system(.caption, design: .rounded, weight: .medium))
                                .foregroundColor(person.gender == gender ? .white : Color.theme(.primaryText))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(person.gender == gender ? Color.theme(.primaryAccent) : Color.theme(.cardBackground))
                                )
                        }
                    }
                }
            }
            
            // Age Input
            VStack(alignment: .leading, spacing: 8) {
                Text("age".localized)
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundColor(Color.theme(.secondaryText))
                
                TextField("age_placeholder".localized, value: $person.age, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .font(.system(.body, design: .rounded, weight: .medium))
                    .foregroundColor(Color.theme(.primaryText))
                    .onChange(of: person.age) { newValue in
                        // Ensure age is within valid range
                        if newValue < 0 {
                            person.age = 0
                        } else if newValue > 100 {
                            person.age = 100
                        }
                    }
            }
            
            // Zodiac Sign Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("zodiac_sign".localized)
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundColor(Color.theme(.secondaryText))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(zodiacSigns, id: \.self) { sign in
                            Button(action: {
                                person.zodiacSign = sign
                            }) {
                                Text(sign.localized)
                                    .font(.system(.caption, design: .rounded, weight: .medium))
                                    .foregroundColor(person.zodiacSign == sign ? .white : Color.theme(.primaryText))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(
                                        Capsule()
                                            .fill(person.zodiacSign == sign ? Color.theme(.secondaryAccent) : Color.theme(.cardBackground))
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme(.cardBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.theme(.border).opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: Color.theme(.shadow), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    NavigationView {
        ZodiacInputView()
    }
}
