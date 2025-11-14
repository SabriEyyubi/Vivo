//
//  RealmSetup.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation
import RealmSwift

// MARK: - Realm Setup Instructions
/*
 To add Realm to your Xcode project:
 
 1. Open your project in Xcode
 2. Go to File > Add Package Dependencies
 3. Enter this URL: https://github.com/realm/realm-swift
 4. Select "RealmSwift" package
 5. Click "Add Package"
 
 Alternative: Add this to your Package.swift if using Swift Package Manager:
 .package(url: "https://github.com/realm/realm-swift", from: "10.0.0")
 
 IMPORTANT: For device compatibility, you may need to:
 1. Clean Build Folder (Cmd+Shift+K)
 2. Delete DerivedData
 3. Re-add the RealmSwift package
 4. Check "Embed & Sign" in Build Phases > Embed Frameworks
 */

class RealmSetup {
    static func configureRealm() {
        // Configure Realm with device-compatible settings
        let config = Realm.Configuration(
            schemaVersion: 2, // Updated for simple models
            migrationBlock: { migration, oldSchemaVersion in
                // Handle migrations here
                if oldSchemaVersion < 2 {
                    // Migration logic for version 2 - from social media to simple models
                }
            }
        )
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    static func seedSampleData() {
        do {
            let realm = try Realm()
            
            // Check if data already exists
            if realm.objects(UserRealm.self).count > 0 {
                return // Data already seeded
            }
            
            try realm.write {
                // Create sample users
                let sampleUsers = [
                    UserRealm(name: "John Doe", email: "john@example.com"),
                    UserRealm(name: "Jane Smith", email: "jane@example.com"),
                    UserRealm(name: "Mike Wilson", email: "mike@example.com")
                ]
                
                realm.add(sampleUsers)
                
                // Create sample posts
                let samplePosts = [
                    PostRealm(title: "Welcome to Vivo", content: "This is a sample post for testing purposes."),
                    PostRealm(title: "Getting Started", content: "Learn how to use the app with these simple steps."),
                    PostRealm(title: "New Features", content: "Check out the latest updates and improvements.")
                ]
                
                realm.add(samplePosts)
                
                // Create sample comments
                let sampleComments = [
                    CommentRealm(content: "Great post! Thanks for sharing."),
                    CommentRealm(content: "This is very helpful information."),
                    CommentRealm(content: "Looking forward to more updates!")
                ]
                
                realm.add(sampleComments)
            }
        } catch {
            print("Error seeding sample data: \(error)")
        }
    }
}


