//
//  Topic.swift
//  Vivo
//
//  Created by Sabri Eyyubi on 6.09.2025.
//

import Foundation
import SwiftUI

// MARK: - Topic Model
struct Topic: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let category: String
    let difficulty: TopicDifficulty
    let language: String
    let tags: [String]
    let isTrending: Bool
    let createdAt: Date
    
    init(title: String, description: String, category: String, difficulty: TopicDifficulty, language: String = "Turkish", tags: [String] = [], isTrending: Bool = false) {
        self.id = UUID().uuidString
        self.title = title
        self.description = description
        self.category = category
        self.difficulty = difficulty
        self.language = language
        self.tags = tags
        self.isTrending = isTrending
        self.createdAt = Date()
    }
}

// MARK: - Topic Difficulty Enum
enum TopicDifficulty: String, CaseIterable, Codable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    
    var displayName: String {
        switch self {
        case .easy: return "Kolay"
        case .medium: return "Orta"
        case .hard: return "Zor"
        }
    }
    
    var color: Color {
        switch self {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
    
    var icon: String {
        switch self {
        case .easy: return "🟢"
        case .medium: return "🟡"
        case .hard: return "🔴"
        }
    }
}

// MARK: - Localized Topic Data
extension Topic {
    static func getDailyTopics(for language: String) -> [Topic] {
        switch language {
        case "tr":
            return turkishTopics
        case "en":
            return englishTopics
        case "es":
            return spanishTopics
        default:
            return turkishTopics
        }
    }
    
    // MARK: - Turkish Topics
    static let turkishTopics: [Topic] = [
        // Technology & Science
        Topic(
            title: "Yapay Zeka Geleceği",
            description: "AI teknolojisinin insan yaşamına etkileri ve gelecekteki gelişimler hakkında tartışalım.",
            category: "Teknoloji",
            difficulty: .medium,
            tags: ["AI", "Teknoloji", "Gelecek"],
            isTrending: true
        ),
        
        Topic(
            title: "Sosyal Medya Etkisi",
            description: "Sosyal medyanın gençler üzerindeki pozitif ve negatif etkilerini değerlendirelim.",
            category: "Sosyal",
            difficulty: .easy,
            tags: ["Sosyal Medya", "Gençlik", "Etki"]
        ),
        
        Topic(
            title: "Uzay Keşifleri",
            description: "Mars'a yolculuk, uzay kolonileri ve insanlığın uzaydaki geleceği hakkında konuşalım.",
            category: "Bilim",
            difficulty: .hard,
            tags: ["Uzay", "Bilim", "Keşif"]
        ),
        
        // Environment & Climate
        Topic(
            title: "İklim Değişikliği Çözümleri",
            description: "Bireysel ve toplumsal düzeyde iklim değişikliği ile mücadele yöntemleri.",
            category: "Çevre",
            difficulty: .medium,
            tags: ["İklim", "Çevre", "Sürdürülebilirlik"],
            isTrending: true
        ),
        
        Topic(
            title: "Sürdürülebilir Yaşam",
            description: "Günlük hayatımızda çevre dostu alışkanlıklar geliştirme yolları.",
            category: "Çevre",
            difficulty: .easy,
            tags: ["Sürdürülebilirlik", "Yaşam", "Çevre"]
        ),
        
        // Education & Learning
        Topic(
            title: "Online Eğitimin Geleceği",
            description: "Pandemi sonrası eğitim sisteminde dijital dönüşüm ve hibrit modeller.",
            category: "Eğitim",
            difficulty: .medium,
            tags: ["Eğitim", "Online", "Dijital"]
        ),
        
        Topic(
            title: "Yaratıcılık ve Sanat",
            description: "Sanatın toplumsal değişimdeki rolü ve yaratıcılığın geliştirilmesi.",
            category: "Sanat",
            difficulty: .easy,
            tags: ["Sanat", "Yaratıcılık", "Kültür"]
        ),
        
        // Health & Wellness
        Topic(
            title: "Mental Sağlık Farkındalığı",
            description: "Modern yaşamın stres etkileri ve mental sağlığı koruma yöntemleri.",
            category: "Sağlık",
            difficulty: .medium,
            tags: ["Mental Sağlık", "Stres", "Wellness"],
            isTrending: true
        ),
        
        Topic(
            title: "Spor ve Yaşam Tarzı",
            description: "Düzenli sporun yaşam kalitesine etkisi ve motivasyon teknikleri.",
            category: "Sağlık",
            difficulty: .easy,
            tags: ["Spor", "Sağlık", "Yaşam Tarzı"]
        ),
        
        // Business & Economy
        Topic(
            title: "Girişimcilik ve İnovasyon",
            description: "Startup ekosistemi, girişimcilik ruhu ve yenilikçi düşünce.",
            category: "İş",
            difficulty: .hard,
            tags: ["Girişimcilik", "İnovasyon", "Startup"]
        ),
        
        Topic(
            title: "Remote Work Kültürü",
            description: "Uzaktan çalışmanın avantajları, dezavantajları ve geleceği.",
            category: "İş",
            difficulty: .medium,
            tags: ["Remote Work", "İş", "Teknoloji"],
            isTrending: true
        ),
        
        // Culture & Society
        Topic(
            title: "Dijital Kültür",
            description: "İnternet kültürünün geleneksel kültür üzerindeki etkileri.",
            category: "Kültür",
            difficulty: .medium,
            tags: ["Dijital", "Kültür", "Toplum"]
        ),
        
        Topic(
            title: "Gen Z ve Milenyaller",
            description: "Farklı nesiller arasındaki değer farklılıkları ve iletişim.",
            category: "Sosyal",
            difficulty: .easy,
            tags: ["Nesil", "Değerler", "İletişim"]
        ),
        
        // Philosophy & Ethics
        Topic(
            title: "Etik ve Teknoloji",
            description: "Teknolojik gelişmelerin etik boyutları ve sorumluluklar.",
            category: "Felsefe",
            difficulty: .hard,
            tags: ["Etik", "Teknoloji", "Sorumluluk"]
        ),
        
        Topic(
            title: "Özgürlük ve Güvenlik",
            description: "Dijital çağda özgürlük ile güvenlik arasındaki denge.",
            category: "Felsefe",
            difficulty: .hard,
            tags: ["Özgürlük", "Güvenlik", "Dijital"]
        ),
        
        // Entertainment & Media
        Topic(
            title: "Streaming Kültürü",
            description: "Dijital platformların eğlence sektörüne etkisi ve geleceği.",
            category: "Eğlence",
            difficulty: .easy,
            tags: ["Streaming", "Eğlence", "Medya"]
        ),
        
        Topic(
            title: "Oyun Endüstrisi",
            description: "Video oyunlarının sanat olarak değeri ve eğitimdeki rolü.",
            category: "Eğlence",
            difficulty: .medium,
            tags: ["Oyun", "Sanat", "Eğitim"]
        ),
        
        // Travel & Lifestyle
        Topic(
            title: "Sürdürülebilir Turizm",
            description: "Çevre dostu seyahat alışkanlıkları ve sorumlu turizm.",
            category: "Seyahat",
            difficulty: .medium,
            tags: ["Turizm", "Sürdürülebilirlik", "Seyahat"]
        ),
        
        Topic(
            title: "Minimalist Yaşam",
            description: "Minimalizm felsefesi ve sade yaşamın avantajları.",
            category: "Yaşam",
            difficulty: .easy,
            tags: ["Minimalizm", "Yaşam", "Sadelik"]
        ),
        
        // Future & Innovation
        Topic(
            title: "Metaverse ve Sanal Dünya",
            description: "Sanal gerçeklik teknolojilerinin gelecekteki rolü ve etkileri.",
            category: "Teknoloji",
            difficulty: .hard,
            tags: ["Metaverse", "VR", "Gelecek"],
            isTrending: true
        )
    ]
    
    // MARK: - English Topics
    static let englishTopics: [Topic] = [
        // Technology & Science
        Topic(
            title: "Future of Artificial Intelligence",
            description: "Let's discuss the impact of AI technology on human life and future developments.",
            category: "Technology",
            difficulty: .medium,
            tags: ["AI", "Technology", "Future"],
            isTrending: true
        ),
        
        Topic(
            title: "Social Media Impact",
            description: "Let's evaluate the positive and negative effects of social media on young people.",
            category: "Social",
            difficulty: .easy,
            tags: ["Social Media", "Youth", "Impact"]
        ),
        
        Topic(
            title: "Space Exploration",
            description: "Let's talk about Mars missions, space colonies and humanity's future in space.",
            category: "Science",
            difficulty: .hard,
            tags: ["Space", "Science", "Exploration"]
        ),
        
        // Environment & Climate
        Topic(
            title: "Climate Change Solutions",
            description: "Methods to combat climate change at individual and societal levels.",
            category: "Environment",
            difficulty: .medium,
            tags: ["Climate", "Environment", "Sustainability"],
            isTrending: true
        ),
        
        Topic(
            title: "Sustainable Living",
            description: "Ways to develop environmentally friendly habits in our daily lives.",
            category: "Environment",
            difficulty: .easy,
            tags: ["Sustainability", "Lifestyle", "Environment"]
        ),
        
        // Education & Learning
        Topic(
            title: "Future of Online Education",
            description: "Digital transformation in education systems and hybrid models post-pandemic.",
            category: "Education",
            difficulty: .medium,
            tags: ["Education", "Online", "Digital"]
        ),
        
        Topic(
            title: "Creativity and Art",
            description: "The role of art in social change and developing creativity.",
            category: "Art",
            difficulty: .easy,
            tags: ["Art", "Creativity", "Culture"]
        ),
        
        // Health & Wellness
        Topic(
            title: "Mental Health Awareness",
            description: "Effects of modern life stress and methods to protect mental health.",
            category: "Health",
            difficulty: .medium,
            tags: ["Mental Health", "Stress", "Wellness"],
            isTrending: true
        ),
        
        Topic(
            title: "Sports and Lifestyle",
            description: "The impact of regular exercise on quality of life and motivation techniques.",
            category: "Health",
            difficulty: .easy,
            tags: ["Sports", "Health", "Lifestyle"]
        ),
        
        // Business & Economy
        Topic(
            title: "Entrepreneurship and Innovation",
            description: "Startup ecosystem, entrepreneurial spirit and innovative thinking.",
            category: "Business",
            difficulty: .hard,
            tags: ["Entrepreneurship", "Innovation", "Startup"]
        ),
        
        Topic(
            title: "Remote Work Culture",
            description: "Advantages, disadvantages and future of remote work.",
            category: "Business",
            difficulty: .medium,
            tags: ["Remote Work", "Business", "Technology"],
            isTrending: true
        ),
        
        // Culture & Society
        Topic(
            title: "Digital Culture",
            description: "The impact of internet culture on traditional culture.",
            category: "Culture",
            difficulty: .medium,
            tags: ["Digital", "Culture", "Society"]
        ),
        
        Topic(
            title: "Gen Z and Millennials",
            description: "Value differences between different generations and communication.",
            category: "Social",
            difficulty: .easy,
            tags: ["Generation", "Values", "Communication"]
        ),
        
        // Philosophy & Ethics
        Topic(
            title: "Ethics and Technology",
            description: "Ethical dimensions of technological developments and responsibilities.",
            category: "Philosophy",
            difficulty: .hard,
            tags: ["Ethics", "Technology", "Responsibility"]
        ),
        
        Topic(
            title: "Freedom and Security",
            description: "The balance between freedom and security in the digital age.",
            category: "Philosophy",
            difficulty: .hard,
            tags: ["Freedom", "Security", "Digital"]
        ),
        
        // Entertainment & Media
        Topic(
            title: "Streaming Culture",
            description: "The impact of digital platforms on the entertainment industry and its future.",
            category: "Entertainment",
            difficulty: .easy,
            tags: ["Streaming", "Entertainment", "Media"]
        ),
        
        Topic(
            title: "Gaming Industry",
            description: "The value of video games as art and their role in education.",
            category: "Entertainment",
            difficulty: .medium,
            tags: ["Gaming", "Art", "Education"]
        ),
        
        // Travel & Lifestyle
        Topic(
            title: "Sustainable Tourism",
            description: "Environmentally friendly travel habits and responsible tourism.",
            category: "Travel",
            difficulty: .medium,
            tags: ["Tourism", "Sustainability", "Travel"]
        ),
        
        Topic(
            title: "Minimalist Living",
            description: "The philosophy of minimalism and advantages of simple living.",
            category: "Lifestyle",
            difficulty: .easy,
            tags: ["Minimalism", "Lifestyle", "Simplicity"]
        ),
        
        // Future & Innovation
        Topic(
            title: "Metaverse and Virtual World",
            description: "The future role and impact of virtual reality technologies.",
            category: "Technology",
            difficulty: .hard,
            tags: ["Metaverse", "VR", "Future"],
            isTrending: true
        )
    ]
    
    // MARK: - Spanish Topics
    static let spanishTopics: [Topic] = [
        // Technology & Science
        Topic(
            title: "Futuro de la Inteligencia Artificial",
            description: "Hablemos sobre el impacto de la tecnología de IA en la vida humana y desarrollos futuros.",
            category: "Tecnología",
            difficulty: .medium,
            tags: ["IA", "Tecnología", "Futuro"],
            isTrending: true
        ),
        
        Topic(
            title: "Impacto de las Redes Sociales",
            description: "Evaluemos los efectos positivos y negativos de las redes sociales en los jóvenes.",
            category: "Social",
            difficulty: .easy,
            tags: ["Redes Sociales", "Juventud", "Impacto"]
        ),
        
        Topic(
            title: "Exploración Espacial",
            description: "Hablemos sobre misiones a Marte, colonias espaciales y el futuro de la humanidad en el espacio.",
            category: "Ciencia",
            difficulty: .hard,
            tags: ["Espacio", "Ciencia", "Exploración"]
        ),
        
        // Environment & Climate
        Topic(
            title: "Soluciones al Cambio Climático",
            description: "Métodos para combatir el cambio climático a nivel individual y social.",
            category: "Medio Ambiente",
            difficulty: .medium,
            tags: ["Clima", "Medio Ambiente", "Sostenibilidad"],
            isTrending: true
        ),
        
        Topic(
            title: "Vida Sostenible",
            description: "Formas de desarrollar hábitos amigables con el medio ambiente en nuestra vida diaria.",
            category: "Medio Ambiente",
            difficulty: .easy,
            tags: ["Sostenibilidad", "Estilo de Vida", "Medio Ambiente"]
        ),
        
        // Education & Learning
        Topic(
            title: "Futuro de la Educación Online",
            description: "Transformación digital en los sistemas educativos y modelos híbridos post-pandemia.",
            category: "Educación",
            difficulty: .medium,
            tags: ["Educación", "Online", "Digital"]
        ),
        
        Topic(
            title: "Creatividad y Arte",
            description: "El papel del arte en el cambio social y el desarrollo de la creatividad.",
            category: "Arte",
            difficulty: .easy,
            tags: ["Arte", "Creatividad", "Cultura"]
        ),
        
        // Health & Wellness
        Topic(
            title: "Conciencia sobre Salud Mental",
            description: "Efectos del estrés de la vida moderna y métodos para proteger la salud mental.",
            category: "Salud",
            difficulty: .medium,
            tags: ["Salud Mental", "Estrés", "Bienestar"],
            isTrending: true
        ),
        
        Topic(
            title: "Deportes y Estilo de Vida",
            description: "El impacto del ejercicio regular en la calidad de vida y técnicas de motivación.",
            category: "Salud",
            difficulty: .easy,
            tags: ["Deportes", "Salud", "Estilo de Vida"]
        ),
        
        // Business & Economy
        Topic(
            title: "Emprendimiento e Innovación",
            description: "Ecosistema de startups, espíritu emprendedor y pensamiento innovador.",
            category: "Negocios",
            difficulty: .hard,
            tags: ["Emprendimiento", "Innovación", "Startup"]
        ),
        
        Topic(
            title: "Cultura del Trabajo Remoto",
            description: "Ventajas, desventajas y futuro del trabajo remoto.",
            category: "Negocios",
            difficulty: .medium,
            tags: ["Trabajo Remoto", "Negocios", "Tecnología"],
            isTrending: true
        ),
        
        // Culture & Society
        Topic(
            title: "Cultura Digital",
            description: "El impacto de la cultura de internet en la cultura tradicional.",
            category: "Cultura",
            difficulty: .medium,
            tags: ["Digital", "Cultura", "Sociedad"]
        ),
        
        Topic(
            title: "Generación Z y Millennials",
            description: "Diferencias de valores entre diferentes generaciones y comunicación.",
            category: "Social",
            difficulty: .easy,
            tags: ["Generación", "Valores", "Comunicación"]
        ),
        
        // Philosophy & Ethics
        Topic(
            title: "Ética y Tecnología",
            description: "Dimensiones éticas de los desarrollos tecnológicos y responsabilidades.",
            category: "Filosofía",
            difficulty: .hard,
            tags: ["Ética", "Tecnología", "Responsabilidad"]
        ),
        
        Topic(
            title: "Libertad y Seguridad",
            description: "El equilibrio entre libertad y seguridad en la era digital.",
            category: "Filosofía",
            difficulty: .hard,
            tags: ["Libertad", "Seguridad", "Digital"]
        ),
        
        // Entertainment & Media
        Topic(
            title: "Cultura de Streaming",
            description: "El impacto de las plataformas digitales en la industria del entretenimiento y su futuro.",
            category: "Entretenimiento",
            difficulty: .easy,
            tags: ["Streaming", "Entretenimiento", "Medios"]
        ),
        
        Topic(
            title: "Industria de los Videojuegos",
            description: "El valor de los videojuegos como arte y su papel en la educación.",
            category: "Entretenimiento",
            difficulty: .medium,
            tags: ["Gaming", "Arte", "Educación"]
        ),
        
        // Travel & Lifestyle
        Topic(
            title: "Turismo Sostenible",
            description: "Hábitos de viaje amigables con el medio ambiente y turismo responsable.",
            category: "Viajes",
            difficulty: .medium,
            tags: ["Turismo", "Sostenibilidad", "Viajes"]
        ),
        
        Topic(
            title: "Vida Minimalista",
            description: "La filosofía del minimalismo y las ventajas de la vida simple.",
            category: "Estilo de Vida",
            difficulty: .easy,
            tags: ["Minimalismo", "Estilo de Vida", "Simplicidad"]
        ),
        
        // Future & Innovation
        Topic(
            title: "Metaverso y Mundo Virtual",
            description: "El papel futuro y el impacto de las tecnologías de realidad virtual.",
            category: "Tecnología",
            difficulty: .hard,
            tags: ["Metaverso", "VR", "Futuro"],
            isTrending: true
        )
    ]
}