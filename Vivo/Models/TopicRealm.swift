//
//  TopicRealm.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation
import RealmSwift

// MARK: - Topic Realm Model (Persistent)
class TopicRealm: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String = ""
    @Persisted var summary: String = ""
    @Persisted var category: String = ""
    @Persisted var language: String = "tr"
    @Persisted var createdAt: Date = Date()

    convenience init(title: String, summary: String, category: String, language: String) {
        self.init()
        self.title = title
        self.summary = summary
        self.category = category
        self.language = language
    }
}
