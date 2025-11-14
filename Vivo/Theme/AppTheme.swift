//
//  AppTheme.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import SwiftUI

// MARK: - Theme Manager
class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var currentTheme: AppTheme = .light
    
    private init() {
        // Load saved theme or detect system preference
        if let savedTheme = UserDefaults.standard.string(forKey: "selected_theme"),
           let theme = AppTheme(rawValue: savedTheme) {
            currentTheme = theme
        } else {
            // Auto-detect system theme with safety check
            DispatchQueue.main.async {
                self.currentTheme = UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
            }
        }
    }
    
    func setTheme(_ theme: AppTheme) {
        currentTheme = theme
        UserDefaults.standard.set(theme.rawValue, forKey: "selected_theme")
    }
    
    func toggleTheme() {
        setTheme(currentTheme == .light ? .dark : .light)
    }
}

// MARK: - Theme Enum
enum AppTheme: String, CaseIterable, Identifiable {
    case light = "light"
    case dark = "dark"
    case system = "system"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }
    
    var icon: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        case .system: return "gear"
        }
    }
}

// MARK: - Color Palette
struct AppColors {
    // MARK: - Light Theme Colors
    struct Light {
        // Primary Background: #FFFFFF (beyaz, temiz ve sade)
        static let primaryBackground = Color(hex: "#FFFFFF")
        
        // Card Background: #F5F7FA (hafif gri → kartlar öne çıkar)
        static let cardBackground = Color(hex: "#F5F7FA")
        
        // Primary Accent: #6C63FF (yaratıcı mor-mavi arası)
        static let primaryAccent = Color(hex: "#6C63FF")
        
        // Secondary Accent: #FF6584 (dinamik pembe-kırmızı → enerjik butonlar için)
        static let secondaryAccent = Color(hex: "#FF6584")
        
        // Primary Text: #1C1C1E (siyahın yumuşatılmış tonu)
        static let primaryText = Color(hex: "#1C1C1E")
        
        // Secondary Text: #6E6E73 (placeholder, secondary text)
        static let secondaryText = Color(hex: "#6E6E73")
        
        // High Contrast Text: #000000 (pure black for maximum visibility)
        static let highContrastText = Color(hex: "#000000")
        
        // Additional colors for better UI
        static let border = Color(hex: "#E5E5EA")
        static let shadow = Color.black.opacity(0.1)
        static let success = Color(hex: "#34C759")
        static let warning = Color(hex: "#FF9500")
        static let error = Color(hex: "#FF3B30")
        
        // Gradient colors for backgrounds
        static let gradientStart = Color(hex: "#6C63FF")
        static let gradientMiddle = Color(hex: "#FF6584")
        static let gradientEnd = Color(hex: "#FFD93D")
        static let gradientLight = Color(hex: "#F8F9FF")
    }
    
    // MARK: - Dark Theme Colors
    struct Dark {
        // Primary Background: #121212 (klasik koyu, göz dostu)
        static let primaryBackground = Color(hex: "#121212")
        
        // Card Background: #2C2C2E (brighter for better text contrast)
        static let cardBackground = Color(hex: "#2C2C2E")
        
        // Primary Accent: #9B51E0 (neon-mor, yaratıcılığı temsil eder)
        static let primaryAccent = Color(hex: "#9B51E0")
        
        // Secondary Accent: #FFD93D (enerjik sarı → dikkat çekici butonlar)
        static let secondaryAccent = Color(hex: "#FFD93D")
        
        // Primary Text: #F2F2F7 (softer white, more comfortable for dark mode)
        static let primaryText = Color(hex: "#F2F2F7")
        
        // Secondary Text: #D1D1D6 (softer secondary text, better readability)
        static let secondaryText = Color(hex: "#D1D1D6")
        
        // High Contrast Text: #FFFFFF (pure white for maximum visibility)
        static let highContrastText = Color(hex: "#FFFFFF")
        
        // Additional colors for better UI
        static let border = Color(hex: "#2C2C2E")
        static let shadow = Color.black.opacity(0.3)
        static let success = Color(hex: "#30D158")
        static let warning = Color(hex: "#FF9F0A")
        static let error = Color(hex: "#FF453A")
        
        // Gradient colors for backgrounds
        static let gradientStart = Color(hex: "#9B51E0")
        static let gradientMiddle = Color(hex: "#FFD93D")
        static let gradientEnd = Color(hex: "#6C63FF")
        static let gradientDark = Color(hex: "#1A1A2E")
    }
}

// MARK: - Theme Colors Extension
extension Color {
    static func theme(_ color: ThemeColor) -> Color {
        let theme = ThemeManager.shared.currentTheme
        
        switch (theme, color) {
        // Light theme colors
        case (.light, .primaryBackground): return AppColors.Light.primaryBackground
        case (.light, .cardBackground): return AppColors.Light.cardBackground
        case (.light, .primaryAccent): return AppColors.Light.primaryAccent
        case (.light, .secondaryAccent): return AppColors.Light.secondaryAccent
        case (.light, .primaryText): return AppColors.Light.primaryText
        case (.light, .secondaryText): return AppColors.Light.secondaryText
        case (.light, .highContrastText): return AppColors.Light.highContrastText
        case (.light, .border): return AppColors.Light.border
        case (.light, .shadow): return AppColors.Light.shadow
        case (.light, .success): return AppColors.Light.success
        case (.light, .warning): return AppColors.Light.warning
        case (.light, .error): return AppColors.Light.error
        case (.light, .gradientStart): return AppColors.Light.gradientStart
        case (.light, .gradientMiddle): return AppColors.Light.gradientMiddle
        case (.light, .gradientEnd): return AppColors.Light.gradientEnd
        case (.light, .gradientLight): return AppColors.Light.gradientLight
        case (.light, .gradientDark): return AppColors.Light.gradientLight // Fallback for light theme
        
        // Dark theme colors
        case (.dark, .primaryBackground): return AppColors.Dark.primaryBackground
        case (.dark, .cardBackground): return AppColors.Dark.cardBackground
        case (.dark, .primaryAccent): return AppColors.Dark.primaryAccent
        case (.dark, .secondaryAccent): return AppColors.Dark.secondaryAccent
        case (.dark, .primaryText): return AppColors.Dark.primaryText
        case (.dark, .secondaryText): return AppColors.Dark.secondaryText
        case (.dark, .highContrastText): return AppColors.Dark.highContrastText
        case (.dark, .border): return AppColors.Dark.border
        case (.dark, .shadow): return AppColors.Dark.shadow
        case (.dark, .success): return AppColors.Dark.success
        case (.dark, .warning): return AppColors.Dark.warning
        case (.dark, .error): return AppColors.Dark.error
        case (.dark, .gradientStart): return AppColors.Dark.gradientStart
        case (.dark, .gradientMiddle): return AppColors.Dark.gradientMiddle
        case (.dark, .gradientEnd): return AppColors.Dark.gradientEnd
        case (.dark, .gradientLight): return AppColors.Dark.gradientDark // Fallback for dark theme
        case (.dark, .gradientDark): return AppColors.Dark.gradientDark
        
        // System theme - use current system appearance
        case (.system, _):
            let isDark = UITraitCollection.current.userInterfaceStyle == .dark
            return isDark ? Color.theme(color, for: .dark) : Color.theme(color, for: .light)
        }
    }
    
    static func theme(_ color: ThemeColor, for theme: AppTheme) -> Color {
        switch (theme, color) {
        case (.light, .primaryBackground): return AppColors.Light.primaryBackground
        case (.light, .cardBackground): return AppColors.Light.cardBackground
        case (.light, .primaryAccent): return AppColors.Light.primaryAccent
        case (.light, .secondaryAccent): return AppColors.Light.secondaryAccent
        case (.light, .primaryText): return AppColors.Light.primaryText
        case (.light, .secondaryText): return AppColors.Light.secondaryText
        case (.light, .highContrastText): return AppColors.Light.highContrastText
        case (.light, .border): return AppColors.Light.border
        case (.light, .shadow): return AppColors.Light.shadow
        case (.light, .success): return AppColors.Light.success
        case (.light, .warning): return AppColors.Light.warning
        case (.light, .error): return AppColors.Light.error
        case (.light, .gradientStart): return AppColors.Light.gradientStart
        case (.light, .gradientMiddle): return AppColors.Light.gradientMiddle
        case (.light, .gradientEnd): return AppColors.Light.gradientEnd
        case (.light, .gradientLight): return AppColors.Light.gradientLight
        case (.light, .gradientDark): return AppColors.Light.gradientLight // Fallback for light theme
        
        case (.dark, .primaryBackground): return AppColors.Dark.primaryBackground
        case (.dark, .cardBackground): return AppColors.Dark.cardBackground
        case (.dark, .primaryAccent): return AppColors.Dark.primaryAccent
        case (.dark, .secondaryAccent): return AppColors.Dark.secondaryAccent
        case (.dark, .primaryText): return AppColors.Dark.primaryText
        case (.dark, .secondaryText): return AppColors.Dark.secondaryText
        case (.dark, .highContrastText): return AppColors.Dark.highContrastText
        case (.dark, .border): return AppColors.Dark.border
        case (.dark, .shadow): return AppColors.Dark.shadow
        case (.dark, .success): return AppColors.Dark.success
        case (.dark, .warning): return AppColors.Dark.warning
        case (.dark, .error): return AppColors.Dark.error
        case (.dark, .gradientStart): return AppColors.Dark.gradientStart
        case (.dark, .gradientMiddle): return AppColors.Dark.gradientMiddle
        case (.dark, .gradientEnd): return AppColors.Dark.gradientEnd
        case (.dark, .gradientLight): return AppColors.Dark.gradientDark // Fallback for dark theme
        case (.dark, .gradientDark): return AppColors.Dark.gradientDark
        
        case (.system, _):
            let isDark = UITraitCollection.current.userInterfaceStyle == .dark
            return isDark ? Color.theme(color, for: .dark) : Color.theme(color, for: .light)
        }
    }
}

// MARK: - Theme Color Enum
enum ThemeColor {
    case primaryBackground
    case cardBackground
    case primaryAccent
    case secondaryAccent
    case primaryText
    case secondaryText
    case highContrastText
    case border
    case shadow
    case success
    case warning
    case error
    case gradientStart
    case gradientMiddle
    case gradientEnd
    case gradientLight
    case gradientDark
}

// MARK: - Color Extension for Hex Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        // Validate hex string
        guard !hex.isEmpty && hex.count >= 3 else {
            self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)
            return
        }
        
        var int: UInt64 = 0
        let scanner = Scanner(string: hex)
        guard scanner.scanHexInt64(&int) else {
            self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)
            return
        }
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0) // Default to black with full opacity
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
