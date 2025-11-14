//
//  User.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation
import RealmSwift

// MARK: - Simple User Model for Basic App
class UserRealm: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var email: String = ""
    @Persisted var createdAt: Date = Date()
    
    convenience init(name: String, email: String) {
        self.init()
        self.name = name
        self.email = email
    }
}

// MARK: - SwiftUI User Model (for UI)
struct User: Identifiable, Codable {
    let id: String
    var name: String
    var email: String
    var createdAt: Date
    
    init(from realmUser: UserRealm) {
        self.id = realmUser.id
        self.name = realmUser.name
        self.email = realmUser.email
        self.createdAt = realmUser.createdAt
    }
    
    init(name: String, email: String) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.createdAt = Date()
    }
}
