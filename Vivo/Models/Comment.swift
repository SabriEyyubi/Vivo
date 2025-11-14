//
//  Comment.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation
import RealmSwift

// MARK: - Simple Comment Model for Basic App
class CommentRealm: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var content: String = ""
    @Persisted var createdAt: Date = Date()
    
    convenience init(content: String) {
        self.init()
        self.content = content
    }
}

// MARK: - SwiftUI Comment Model (for UI)
struct Comment: Identifiable, Codable {
    let id: String
    let content: String
    let createdAt: Date
    
    init(from realmComment: CommentRealm) {
        self.id = realmComment.id
        self.content = realmComment.content
        self.createdAt = realmComment.createdAt
    }
    
    init(content: String) {
        self.id = UUID().uuidString
        self.content = content
        self.createdAt = Date()
    }
}


