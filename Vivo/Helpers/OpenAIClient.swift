//
//  OpenAIClient.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation

enum OpenAIClientError: Error {
    case invalidURL
    case missingAPIKey
    case invalidResponse
    case apiError(String)
    case emptyResponse
    case decodingFailed
}

struct OpenAIClient {
    static let shared = OpenAIClient()

    private let endpoint = "https://api.openai.com/v1/chat/completions"
    private let model = "gpt-4o"

    func fetchZodiacTopics(
        people: [PersonInfo],
        languageCode: String,
        apiKey: String
    ) async throws -> [ZodiacTopic] {
        guard !apiKey.isEmpty else { throw OpenAIClientError.missingAPIKey }
        guard let url = URL(string: endpoint) else { throw OpenAIClientError.invalidURL }

        let systemPrompt = "You are a helpful assistant. Output JSON only."
        let userPrompt = buildUserPrompt(people: people, languageCode: languageCode)

        let requestBody = ChatCompletionRequest(
            model: model,
            messages: [
                ChatMessagePayload(role: "system", content: systemPrompt),
                ChatMessagePayload(role: "user", content: userPrompt)
            ],
            temperature: 0.7
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(requestBody)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw OpenAIClientError.invalidResponse
        }

        if !(200..<300).contains(http.statusCode) {
            let body = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw OpenAIClientError.apiError("HTTP \(http.statusCode): \(body)")
        }

        let decoded = try JSONDecoder().decode(ChatCompletionResponse.self, from: data)
        guard let content = decoded.choices.first?.message.content, !content.isEmpty else {
            throw OpenAIClientError.emptyResponse
        }

        let jsonString = extractJSON(from: content)
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw OpenAIClientError.decodingFailed
        }

        let payload = try JSONDecoder().decode(ZodiacTopicResponse.self, from: jsonData)
        return payload.topics.enumerated().map { index, item in
            ZodiacTopic(
                id: index + 1,
                title: item.title,
                description: item.description,
                difficulty: item.difficulty,
                zodiacSigns: item.zodiacSigns,
                isTrending: item.isTrending ?? false
            )
        }
    }

    private func buildUserPrompt(people: [PersonInfo], languageCode: String) -> String {
        let languageName: String
        switch languageCode {
        case "tr": languageName = "Turkish"
        case "es": languageName = "Spanish"
        default: languageName = "English"
        }

        let peopleLines = people.enumerated().map { index, person in
            "Person \(index + 1): gender=\(person.gender), age=\(person.age), zodiac=\(person.zodiacSign)"
        }
        .joined(separator: "\n")

        let allowedSigns = "aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces"

        return """
        Generate 10 conversation topics based on the people info below.
        Language: \(languageName).
        Use zodiac sign keys from this list only: \(allowedSigns).
        Difficulty must be one of: easy, medium, hard.
        If there are multiple people, prioritize deeper relationship and life topics (communication, values, long-term goals), especially for female+female or female+male pairs.
        Return JSON with this exact shape:
        {"topics":[{"title":"...","description":"...","difficulty":"easy|medium|hard","zodiacSigns":["aries"],"isTrending":true}]}

        People:
        \(peopleLines)
        """
    }

    private func extractJSON(from content: String) -> String {
        if content.trimmingCharacters(in: .whitespacesAndNewlines).first == "{" {
            return content
        }

        guard let start = content.firstIndex(of: "{"),
              let end = content.lastIndex(of: "}") else {
            return content
        }
        return String(content[start...end])
    }
}

struct ChatCompletionRequest: Encodable {
    let model: String
    let messages: [ChatMessagePayload]
    let temperature: Double
}

struct ChatMessagePayload: Encodable {
    let role: String
    let content: String
}

struct ChatCompletionResponse: Decodable {
    let choices: [ChatCompletionChoice]
}

struct ChatCompletionChoice: Decodable {
    let message: ChatCompletionMessage
}

struct ChatCompletionMessage: Decodable {
    let content: String
}

struct ZodiacTopicResponse: Decodable {
    let topics: [ZodiacTopicPayload]
}

struct ZodiacTopicPayload: Decodable {
    let title: String
    let description: String
    let difficulty: String
    let zodiacSigns: [String]
    let isTrending: Bool?
}
