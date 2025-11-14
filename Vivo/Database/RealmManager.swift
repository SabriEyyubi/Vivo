//
//  RealmManager.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    static let shared = RealmManager()
    
    private let realm: Realm
    
    private init() {
        do {
            // Configure Realm with device-compatible settings
            var config = Realm.Configuration()
            config.schemaVersion = 2 // Updated for new simple models
            config.migrationBlock = { migration, oldSchemaVersion in
                // Handle migrations here if needed
                if oldSchemaVersion < 2 {
                    // Migration from social media models to simple models
                }
            }
            
            // Use in-memory database for testing or file-based for production
            #if DEBUG
            // For development, use in-memory database to avoid file system issues
            config.inMemoryIdentifier = "VivoDebugRealm"
            #else
            // For production, use file-based database with proper file permissions
            config.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("vivo.realm")
            #endif
            
            self.realm = try Realm(configuration: config)
        } catch {
            print("Failed to initialize Realm: \(error)")
            // Create a fallback in-memory realm
            do {
                var fallbackConfig = Realm.Configuration()
                fallbackConfig.inMemoryIdentifier = "VivoFallbackRealm"
                self.realm = try Realm(configuration: fallbackConfig)
            } catch {
                fatalError("Failed to initialize fallback Realm: \(error)")
            }
        }
    }
    
    // MARK: - User Operations
    func saveUser(_ user: UserRealm) {
        do {
            try realm.write {
                realm.add(user, update: .modified)
            }
        } catch {
            print("Error saving user: \(error)")
        }
    }
    
    func getUser(by id: String) -> UserRealm? {
        return realm.object(ofType: UserRealm.self, forPrimaryKey: id)
    }
    
    func getAllUsers() -> Results<UserRealm> {
        return realm.objects(UserRealm.self)
    }
    
    // MARK: - Post Operations
    func savePost(_ post: PostRealm) {
        do {
            try realm.write {
                realm.add(post, update: .modified)
            }
        } catch {
            print("Error saving post: \(error)")
        }
    }
    
    func getPost(by id: String) -> PostRealm? {
        return realm.object(ofType: PostRealm.self, forPrimaryKey: id)
    }
    
    func getAllPosts() -> Results<PostRealm> {
        return realm.objects(PostRealm.self).sorted(byKeyPath: "createdAt", ascending: false)
    }
    
    // MARK: - Comment Operations
    func saveComment(_ comment: CommentRealm) {
        do {
            try realm.write {
                realm.add(comment, update: .modified)
            }
        } catch {
            print("Error saving comment: \(error)")
        }
    }
    
    func getAllComments() -> Results<CommentRealm> {
        return realm.objects(CommentRealm.self).sorted(byKeyPath: "createdAt", ascending: false)
    }
    
    // MARK: - Search Operations
    func searchUsers(query: String) -> Results<UserRealm> {
        return realm.objects(UserRealm.self)
            .filter("name CONTAINS[cd] %@ OR email CONTAINS[cd] %@", query, query)
    }
    
    func searchPosts(query: String) -> Results<PostRealm> {
        return realm.objects(PostRealm.self)
            .filter("title CONTAINS[cd] %@ OR content CONTAINS[cd] %@", query, query)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }
}
