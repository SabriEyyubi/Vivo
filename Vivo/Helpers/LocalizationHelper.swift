//
//  LocalizationHelper.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation
import SwiftUI

// MARK: - Localization Helper
class LocalizationHelper: ObservableObject {
    static let shared = LocalizationHelper()
    
    @Published var currentLanguage: Language = .english
    
    private init() {
        // Get current language from system or saved preference
        if let savedLanguage = UserDefaults.standard.string(forKey: "selected_language"),
           let language = Language(rawValue: savedLanguage) {
            currentLanguage = language
        } else {
            // Detect system language
            let systemLanguage = Locale.current.language.languageCode?.identifier ?? "en"
            currentLanguage = Language.fromSystemLanguage(systemLanguage)
        }
    }
    
    func setLanguage(_ language: Language) {
        currentLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: "selected_language")
        
        // Force UI update
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func toggleLanguage() {
        let allLanguages = Language.allCases
        if let currentIndex = allLanguages.firstIndex(of: currentLanguage) {
            let nextIndex = (currentIndex + 1) % allLanguages.count
            setLanguage(allLanguages[nextIndex])
        }
    }
    
    func getLocalizedString(for key: String) -> String {
        // First try to get localized string from current language bundle
        if let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
            // If the localized string is the same as the key, it means the key doesn't exist
            if localizedString != key {
                return localizedString
            }
        }
        
        // Fallback to main bundle
        let mainBundleString = NSLocalizedString(key, comment: "")
        if mainBundleString != key {
            return mainBundleString
        }
        
        // If key doesn't exist in any bundle, return the key itself to prevent crash
        return key
    }
}

// MARK: - Language Enum
enum Language: String, CaseIterable, Identifiable {
    case english = "en"
    case turkish = "tr"
    case spanish = "es"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .turkish: return "Türkçe"
        case .spanish: return "Español"
        }
    }
    
    var flag: String {
        switch self {
        case .english: return "🇺🇸"
        case .turkish: return "🇹🇷"
        case .spanish: return "🇪🇸"
        }
    }
    
    static func fromSystemLanguage(_ systemLanguage: String) -> Language {
        switch systemLanguage.prefix(2) {
        case "tr": return .turkish
        case "es": return .spanish
        default: return .english
        }
    }
}

// MARK: - String Extension for Localization
extension String {
    var localized: String {
        return LocalizationHelper.shared.getLocalizedString(for: self)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        let localizedString = LocalizationHelper.shared.getLocalizedString(for: self)
        return String(format: localizedString, arguments: arguments)
    }
}

// MARK: - Bundle Extension for Language Switching
extension Bundle {
    private static var bundle: Bundle?
    
    public static func localizedBundle() -> Bundle {
        return bundle ?? Bundle.main
    }
    
    public static func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, Bundle.self)
        }
        
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let languageBundle = Bundle(path: path) else {
            bundle = Bundle.main
            return
        }
        bundle = languageBundle
    }
}

// MARK: - Custom LocalizedStringKey for Dynamic Language Switching
struct LocalizedString: ExpressibleByStringLiteral {
    let key: String
    let arguments: [CVarArg]
    
    init(stringLiteral value: String) {
        self.key = value
        self.arguments = []
    }
    
    init(_ key: String, arguments: CVarArg...) {
        self.key = key
        self.arguments = arguments
    }
    
    var localized: String {
        let localizedString = NSLocalizedString(key, comment: "")
        if arguments.isEmpty {
            return localizedString == key ? key : localizedString
        } else {
            do {
                return String(format: localizedString, arguments: arguments)
            } catch {
                return localizedString == key ? key : localizedString
            }
        }
    }
}

// MARK: - SwiftUI LocalizedStringKey Extension
extension LocalizedStringKey {
    init(_ key: String, arguments: CVarArg...) {
        self = LocalizedStringKey(String(format: NSLocalizedString(key, comment: ""), arguments: arguments))
    }
}

// MARK: - Time Formatting Helper
struct TimeFormatter {
    static func timeAgo(from date: Date) -> String {
        let now = Date()
        let timeInterval = now.timeIntervalSince(date)
        
        let minute: Double = 60
        let hour: Double = 60 * minute
        let day: Double = 24 * hour
        let week: Double = 7 * day
        let month: Double = 30 * day
        let year: Double = 365 * day
        
        if timeInterval < minute {
            return "now".localized
        } else if timeInterval < hour {
            let minutes = Int(timeInterval / minute)
            return minutes == 1 ? "minute_ago".localized(with: minutes) : "minutes_ago".localized(with: minutes)
        } else if timeInterval < day {
            let hours = Int(timeInterval / hour)
            return hours == 1 ? "hour_ago".localized(with: hours) : "hours_ago".localized(with: hours)
        } else if timeInterval < week {
            let days = Int(timeInterval / day)
            return days == 1 ? "day_ago".localized(with: days) : "days_ago".localized(with: days)
        } else if timeInterval < month {
            let weeks = Int(timeInterval / week)
            return weeks == 1 ? "week_ago".localized(with: weeks) : "weeks_ago".localized(with: weeks)
        } else if timeInterval < year {
            let months = Int(timeInterval / month)
            return months == 1 ? "month_ago".localized(with: months) : "months_ago".localized(with: months)
        } else {
            let years = Int(timeInterval / year)
            return years == 1 ? "year_ago".localized(with: years) : "years_ago".localized(with: years)
        }
    }
}
