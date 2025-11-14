//
//  Post.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation
import RealmSwift

// MARK: - Simple Post Model for Basic App
class PostRealm: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String = ""
    @Persisted var content: String = ""
    @Persisted var createdAt: Date = Date()
    
    convenience init(title: String, content: String) {
        self.init()
        self.title = title
        self.content = content
    }
}

// MARK: - SwiftUI Post Model (for UI)
struct Post: Identifiable, Codable {
    let id: String
    let title: String
    let content: String
    let createdAt: Date
    
    init(from realmPost: PostRealm) {
        self.id = realmPost.id
        self.title = realmPost.title
        self.content = realmPost.content
        self.createdAt = realmPost.createdAt
    }
    
    init(title: String, content: String) {
        self.id = UUID().uuidString
        self.title = title
        self.content = content
        self.createdAt = Date()
    }
}
