

import SwiftUI

struct LanguageSelectorButton: View {
    @StateObject private var localizationHelper = LocalizationHelper.shared
    @State private var showingLanguageMenu = false
    @State private var refreshID = UUID()
    
    let position: Position
    let style: Style
    
    enum Position {
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }
    
    enum Style {
        case compact
        case full
        case minimal
    }
    
    init(position: Position = .topTrailing, style: Style = .compact) {
        self.position = position
        self.style = style
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Main button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showingLanguageMenu.toggle()
                }
            }) {
                HStack(spacing: 6) {
                    Text(localizationHelper.currentLanguage.flag)
                        .font(.title3)
                    
                    Text(localizationHelper.currentLanguage.displayName)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color.theme(.primaryText))
                    
                    Image(systemName: showingLanguageMenu ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color.theme(.secondaryText))
                        .rotationEffect(.degrees(showingLanguageMenu ? 180 : 0))
                        .animation(.easeInOut(duration: 0.2), value: showingLanguageMenu)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.theme(.cardBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.theme(.border), lineWidth: 1)
                        )
                        .shadow(color: Color.theme(.shadow), radius: 3, x: 0, y: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            // Dropdown menu
            if showingLanguageMenu {
                VStack(spacing: 0) {
                    ForEach(Language.allCases) { language in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.15)) {
                                localizationHelper.setLanguage(language)
                                showingLanguageMenu = false
                                refreshID = UUID()
                            }
                        }) {
                            HStack(spacing: 4) {
                                Text(language.flag)
                                    .font(.system(size: 16))
                                
                                Text(language.displayName)
                                    .font(.system(size: 13, weight: language == localizationHelper.currentLanguage ? .semibold : .medium))
                                    .foregroundColor(Color.theme(.primaryText))
                                
                                if language == localizationHelper.currentLanguage {
                                    Spacer()
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.theme(.primaryAccent))
                                }
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(language == localizationHelper.currentLanguage ? Color.theme(.primaryAccent).opacity(0.1) : Color.clear)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if language != Language.allCases.last {
                            Divider()
                                .padding(.horizontal, 8)
                        }
                    }
                }
                .frame(maxWidth: 120)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.theme(.cardBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.theme(.border), lineWidth: 1)
                        )
                        .shadow(color: Color.theme(.shadow), radius: 4, x: 0, y: 2)
                )
                .padding(.top, 2)
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .scale(scale: 0.95, anchor: .top)),
                    removal: .opacity.combined(with: .scale(scale: 0.95, anchor: .top))
                ))
            }
        }
        .id(refreshID)
        .positioned(in: position)
    }
}


// MARK: - Positioned Modifier
extension View {
    func positioned(in position: LanguageSelectorButton.Position) -> some View {
        self.modifier(PositionedModifier(position: position))
    }
}

struct PositionedModifier: ViewModifier {
    let position: LanguageSelectorButton.Position
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .position(
                    x: position == .topLeading || position == .bottomLeading ? 60 : geometry.size.width - 60,
                    y: position == .topLeading || position == .topTrailing ? 60 : geometry.size.height - 60
                )
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color(.systemGray5)
            .ignoresSafeArea()
        
        VStack {
            Text("Language Selector Demo")
                .font(.title)
                .padding()
            
            Spacer()
        }
        
        // Show all positions for preview
        LanguageSelectorButton(position: .topLeading, style: .compact)
        LanguageSelectorButton(position: .topTrailing, style: .full)
        LanguageSelectorButton(position: .bottomLeading, style: .minimal)
        LanguageSelectorButton(position: .bottomTrailing, style: .compact)
    }
}
