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
    private static let topicSeedVersion = 3

    static func configureRealm() {
        // Configure Realm with device-compatible settings
        var config = Realm.Configuration(
            schemaVersion: 4, // Updated for TopicRealm language field
            migrationBlock: { migration, oldSchemaVersion in
                // Handle migrations here
                if oldSchemaVersion < 4 {
                    // Migration logic for version 4 - TopicRealm language field
                }
            }
        )

        // Always use a file-based Realm so data is persistent in Debug and Release
        if let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            config.fileURL = docsURL.appendingPathComponent("vivo.realm")
        }

        Realm.Configuration.defaultConfiguration = config
    }
    
    static func seedSampleData() {
        do {
            let realm = try Realm()
            
            // Seed base sample data if needed
            if realm.objects(UserRealm.self).isEmpty {
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
            }

            seedTopicsIfNeeded(in: realm)
        } catch {
            print("Error seeding sample data: \(error)")
        }
    }

    private static func seedTopicsIfNeeded(in realm: Realm) {
        let currentVersion = UserDefaults.standard.integer(forKey: "topic_seed_version")
        if currentVersion == topicSeedVersion && !realm.objects(TopicRealm.self).isEmpty {
            return
        }

        let generatedTopics = generateTopics()

        do {
            try realm.write {
                realm.delete(realm.objects(TopicRealm.self))
                realm.add(generatedTopics)
            }
            UserDefaults.standard.set(topicSeedVersion, forKey: "topic_seed_version")
        } catch {
            print("Error seeding topics: \(error)")
        }
    }

    private static func generateTopics() -> [TopicRealm] {
        let categorySeedsTR: [String: [String]] = [
            "Teknoloji": [
                "AI Ajanları",
                "Yapay Zeka Etiği",
                "Büyük Dil Modelleri",
                "Cihaz Üstü Yapay Zeka",
                "Siber Güvenlikte AI",
                "Kuantum Hesaplama",
                "5G ve 6G Ağları",
                "IoT ve Akıllı Evler",
                "Bulut Yerel Mimari",
                "Sıfır Güven Yaklaşımı",
                "Veri Gizliliği",
                "Dijital Kimlik",
                "Blokzincir Kullanım Alanları",
                "AR ve VR Deneyimleri",
                "Otomasyon ve RPA",
                "Enerji Verimli Yazılım",
                "Yeşil Veri Merkezleri",
                "Açık Kaynak Güvenliği",
                "Fintech Yenilikleri",
                "Robotik ve Cobotlar"
            ],
            "Sosyal": [
                "Sosyal Medya Algoritmaları",
                "Dijital Detoks",
                "Online Topluluklar",
                "Yalnızlık ve Aidiyet",
                "Gen Z İletişimi",
                "Aile İçi İletişim",
                "Sosyal Medya Güvenliği",
                "Dezenformasyonla Mücadele",
                "Mahremiyet ve Paylaşım",
                "Dijital Nezaket",
                "Çevrimiçi Gönüllülük",
                "Şehir Yaşamı",
                "İş-Yaşam Dengesi",
                "Göç ve Uyum",
                "Toplumsal Cinsiyet Eşitliği",
                "Dijital Vatandaşlık",
                "Krizde Dayanışma",
                "Influencer Ekonomisi",
                "Topluluk Temelli Öğrenme",
                "Yerel Kültürlerin Korunması"
            ],
            "Bilim": [
                "İklim Modellemesi",
                "Uzay Keşifleri",
                "Mars Görevleri",
                "Gen Düzenleme",
                "Biyoteknoloji",
                "Nörobilim",
                "Kuantum Fiziği",
                "Karanlık Madde",
                "Yenilenebilir Enerji Teknolojileri",
                "Batarya Kimyası",
                "Okyanus Araştırmaları",
                "Pandemi Hazırlığı",
                "Aşı Teknolojileri",
                "Yapay Organlar",
                "Malzeme Bilimi",
                "Nanoteknoloji",
                "Astrobiyoloji",
                "Bilim İletişimi",
                "Açık Veri Bilimi",
                "Bilimsel Etik"
            ],
            "Sanat": [
                "Dijital Sanat",
                "Yapay Zeka ile Sanat",
                "Sokak Sanatı",
                "Modern Resim",
                "Çağdaş Heykel",
                "Fotoğrafçılık Trendleri",
                "Tipografi ve Grafik",
                "İllüstrasyon",
                "Performans Sanatı",
                "Müzelerde Dijital Deneyim",
                "Sanat Terapisi",
                "Yerel Kültür ve Sanat",
                "Minimalizm",
                "Renk Teorisi",
                "Sanatta Sürdürülebilirlik",
                "Kamusal Sanat",
                "Sanat Koleksiyonculuğu",
                "Tasarım Düşüncesi",
                "Geleneksel El Sanatları",
                "Sanat Eğitimi"
            ],
            "Spor": [
                "Futbolda Taktikler",
                "Basketbolda Veri Analitiği",
                "E-Spor Ekosistemi",
                "Antrenman Bilimi",
                "Spor Beslenmesi",
                "Sakatlık Önleme",
                "Spor Psikolojisi",
                "Performans Teknolojileri",
                "Amatör Spor Kültürü",
                "Kadın Sporları",
                "Spor ve Sürdürülebilirlik",
                "Koşu ve Maraton",
                "Yüzme Teknikleri",
                "Fitness Trendleri",
                "Genç Sporcular",
                "VAR ve Hakem Teknolojileri",
                "Spor Pazarlaması",
                "Takım Dinamikleri",
                "Recovery ve Uyku",
                "Outdoor Sporlar"
            ],
            "Müzik": [
                "Streaming Ekonomisi",
                "Kısa Video ve Müzik Keşfi",
                "Yapay Zeka ile Üretim",
                "Canlı Performans Deneyimi",
                "Bağımsız Sanatçılar",
                "Telif ve Hak Yönetimi",
                "Lo-fi ve Ambient Akımlar",
                "Hip-Hop Evrimi",
                "Elektronik Müzik Sahnesi",
                "Dünya Müziği",
                "Konser Deneyimi",
                "Ev Stüdyo Kurulumu",
                "Mix ve Master Teknikleri",
                "Dizi ve Film Müzikleri",
                "Marka İşbirlikleri",
                "Playlist Stratejileri",
                "Müzik ve Oyun",
                "Müzik Terapisi",
                "Vokal Teknikleri",
                "Enstrüman Öğrenme"
            ],
            "Film": [
                "Streaming Platform Stratejileri",
                "Sinema ve Dijital Yayın",
                "Kısa Film Anlatısı",
                "Belgesel Trendleri",
                "Yapay Zeka ve VFX",
                "Senaryo Yazımı",
                "Karakter Derinliği",
                "Sinematografi",
                "Dizi Anlatısı",
                "Franchise ve Devam Filmleri",
                "Bağımsız Sinema",
                "Festival Kültürü",
                "Türkiye Sineması",
                "Animasyon Teknikleri",
                "Yapım Bütçeleri",
                "Seyirci Alışkanlıkları",
                "Sinema Pazarlaması",
                "Çeşitlilik ve Temsil",
                "Gerçek Hikaye Uyarlamaları",
                "Film Eleştirisi"
            ],
            "Kitap": [
                "E-Kitap ve Basılı Kitap",
                "Sesli Kitap Trendleri",
                "Kısa Form Okuma",
                "Fantastik Edebiyat",
                "Bilim Kurgu",
                "Polisiye ve Gerilim",
                "Kişisel Gelişim",
                "Güncel Nonfiction",
                "Çeviri Edebiyat",
                "Genç Yetişkin",
                "Okuma Alışkanlıkları",
                "Yazarların Dijital Varlığı",
                "Kitap Kulüpleri",
                "Sansür ve Özgürlük",
                "Edebiyatta Yapay Zeka",
                "Klasiklerin Yeniden Okunması",
                "Çocuk Edebiyatı",
                "Grafik Roman",
                "Yayıncılıkta Sürdürülebilirlik",
                "Kapak Tasarımı"
            ],
            "Yemek": [
                "Sağlıklı Beslenme",
                "Bitki Bazlı Mutfak",
                "Fermentasyon",
                "Yerel Mutfaklar",
                "Sıfır Atık Mutfak",
                "Hızlı ve Pratik Tarifler",
                "Kahve Kültürü",
                "Çay Kültürü",
                "Sokak Lezzetleri",
                "Ev Yapımı Ekmek",
                "Baharatlar ve Aroma",
                "Mevsimsel Beslenme",
                "Dengeli Beslenme Alışkanlıkları",
                "Gıda Güvenliği",
                "Yemek Fotoğrafçılığı",
                "Fine Dining Deneyimi",
                "Vegan Tatlılar",
                "Çocuklar için Beslenme",
                "Gurme Atıştırmalıklar",
                "Yemek Planlama"
            ],
            "Seyahat": [
                "Sürdürülebilir Turizm",
                "Dijital Göçebelik",
                "Uygun Bütçeli Seyahat",
                "Yavaş Seyahat",
                "Kültürel Deneyimler",
                "Doğa Rotaları",
                "Şehir Kaçamakları",
                "Gastronomi Turları",
                "Güvenli Seyahat",
                "Vize ve Planlama",
                "Aile ile Seyahat",
                "Solo Seyahat",
                "Yerel Halkla Etkileşim",
                "Tren Yolculukları",
                "Karavan ve Kamp",
                "Kış ve Kayak Rotaları",
                "Deniz Tatilleri",
                "Fotoğraf Rotaları",
                "Seyahat Teknolojileri",
                "Acil Durum Hazırlığı"
            ],
            "Moda": [
                "Sürdürülebilir Moda",
                "İkinci El ve Yeniden Kullanım",
                "Kapsül Gardırop",
                "Sokak Modası",
                "Minimalist Stil",
                "Renk Trendleri",
                "Aksesuar Seçimi",
                "Athleisure",
                "Teknolojik Kumaşlar",
                "Yerli Tasarımcılar",
                "Moda ve Kültür",
                "Moda Haftaları",
                "Styling İpuçları",
                "Beden Çeşitliliği",
                "Etik Üretim",
                "Vintage Akımı",
                "Unisex Moda",
                "Hızlı Modanın Etkileri",
                "Upcycle ve Dönüşüm",
                "İş Giyimi"
            ],
            "Sağlık": [
                "Zihinsel Sağlık",
                "Uyku Hijyeni",
                "Beslenme ve Sağlık",
                "Düzenli Egzersiz",
                "Bağışıklık Desteği",
                "Tele-Sağlık",
                "Dijital Sağlık Uygulamaları",
                "Stres Yönetimi",
                "Mindfulness",
                "Kronik Hastalık Yönetimi",
                "Sağlık Okuryazarlığı",
                "Kadın Sağlığı",
                "Erkek Sağlığı",
                "Çocuk Sağlığı",
                "Yaşlı Sağlığı",
                "Sağlıklı Yaşlanma",
                "Giyilebilir Cihazlar",
                "Sağlıkta Veri Gizliliği",
                "İlk Yardım Bilinci",
                "Koruyucu Sağlık"
            ],
            "Eğitim": [
                "Hibrit Eğitim",
                "Yapay Zeka Destekli Öğrenme",
                "Mikro Öğrenme",
                "Yaşam Boyu Öğrenme",
                "Eğitimde Oyunlaştırma",
                "Uzaktan Değerlendirme",
                "Öğretmen Destek Araçları",
                "Yabancı Dil Öğrenme",
                "STEM Eğitim",
                "Kodlama Okuryazarlığı",
                "Eleştirel Düşünme",
                "Medya Okuryazarlığı",
                "Proje Tabanlı Öğrenme",
                "Kariyer Yönlendirme",
                "Mesleki Eğitim",
                "Özel Eğitim",
                "Erişilebilir Eğitim",
                "Eğitimde Eşitlik",
                "Sınav Kaygısı",
                "Öğrenme Alışkanlıkları"
            ],
            "Çevre": [
                "İklim Değişikliği Çözümleri",
                "Yenilenebilir Enerji",
                "Karbon Ayak İzi",
                "Döngüsel Ekonomi",
                "Atık Yönetimi",
                "Plastik Azaltma",
                "Su Tasarrufu",
                "Biyoçeşitlilik",
                "Yeşil Şehirler",
                "Toplu Taşıma",
                "Orman Koruma",
                "Sürdürülebilir Tarım",
                "Deniz Kirliliği",
                "Hava Kalitesi",
                "İklim Adaleti",
                "Yeşil Teknoloji",
                "Enerji Verimliliği",
                "Sıfır Atık Yaşam",
                "Ekoturizm",
                "Doğa Restorasyonu"
            ],
            "İş Hayatı": [
                "Uzaktan Çalışma",
                "Hibrit Kültür",
                "Performans Ölçümü",
                "Liderlik Becerileri",
                "Takım İletişimi",
                "Çalışan Deneyimi",
                "İş-Yaşam Dengesi",
                "Kariyer Planlama",
                "Upskilling ve Reskilling",
                "İK Analitiği",
                "Agile Çalışma",
                "Proje Yönetimi",
                "Startup Ekosistemi",
                "Finansal Okuryazarlık",
                "Girişimcilik",
                "Satış Stratejileri",
                "Pazarlama Trendleri",
                "Müşteri Deneyimi",
                "İş Etiği",
                "İş Güvenliği"
            ]
        ]

        let categorySeedsEN: [String: [String]] = [
            "Teknoloji": [
                "AI Agents",
                "AI Ethics",
                "Large Language Models",
                "On-Device AI",
                "AI in Cybersecurity",
                "Quantum Computing",
                "5G and 6G Networks",
                "IoT and Smart Homes",
                "Cloud-Native Architecture",
                "Zero Trust",
                "Data Privacy",
                "Digital Identity",
                "Blockchain Use Cases",
                "AR and VR Experiences",
                "Automation and RPA",
                "Energy-Efficient Software",
                "Green Data Centers",
                "Open-Source Security",
                "Fintech Innovation",
                "Robotics and Cobots"
            ],
            "Sosyal": [
                "Social Media Algorithms",
                "Digital Detox",
                "Online Communities",
                "Loneliness and Belonging",
                "Gen Z Communication",
                "Family Communication",
                "Social Media Safety",
                "Fighting Misinformation",
                "Privacy and Sharing",
                "Digital Etiquette",
                "Online Volunteering",
                "Urban Life",
                "Work-Life Balance",
                "Migration and Integration",
                "Gender Equality",
                "Digital Citizenship",
                "Solidarity in Crisis",
                "Influencer Economy",
                "Community-Based Learning",
                "Protecting Local Cultures"
            ],
            "Bilim": [
                "Climate Modeling",
                "Space Exploration",
                "Mars Missions",
                "Gene Editing",
                "Biotechnology",
                "Neuroscience",
                "Quantum Physics",
                "Dark Matter",
                "Renewable Energy Tech",
                "Battery Chemistry",
                "Ocean Research",
                "Pandemic Preparedness",
                "Vaccine Technologies",
                "Artificial Organs",
                "Materials Science",
                "Nanotechnology",
                "Astrobiology",
                "Science Communication",
                "Open Data Science",
                "Scientific Ethics"
            ],
            "Sanat": [
                "Digital Art",
                "AI in Art",
                "Street Art",
                "Modern Painting",
                "Contemporary Sculpture",
                "Photography Trends",
                "Typography and Graphic Design",
                "Illustration",
                "Performance Art",
                "Digital Museum Experiences",
                "Art Therapy",
                "Local Culture and Art",
                "Minimalism",
                "Color Theory",
                "Sustainable Art",
                "Public Art",
                "Art Collecting",
                "Design Thinking",
                "Traditional Crafts",
                "Art Education"
            ],
            "Spor": [
                "Football Tactics",
                "Basketball Analytics",
                "Esports Ecosystem",
                "Training Science",
                "Sports Nutrition",
                "Injury Prevention",
                "Sports Psychology",
                "Performance Technologies",
                "Amateur Sports Culture",
                "Women in Sports",
                "Sustainability in Sports",
                "Running and Marathons",
                "Swimming Techniques",
                "Fitness Trends",
                "Youth Athletes",
                "VAR and Referee Tech",
                "Sports Marketing",
                "Team Dynamics",
                "Recovery and Sleep",
                "Outdoor Sports"
            ],
            "Müzik": [
                "Streaming Economy",
                "Short Video and Music Discovery",
                "AI Music Production",
                "Live Performance Experience",
                "Independent Artists",
                "Copyright and Rights",
                "Lo-fi and Ambient Trends",
                "Hip-Hop Evolution",
                "Electronic Music Scene",
                "World Music",
                "Concert Experience",
                "Home Studio Setup",
                "Mixing and Mastering",
                "Film and Series Scores",
                "Brand Collaborations",
                "Playlist Strategy",
                "Music and Gaming",
                "Music Therapy",
                "Vocal Techniques",
                "Learning Instruments"
            ],
            "Film": [
                "Streaming Platform Strategies",
                "Cinema vs Digital",
                "Short Film Storytelling",
                "Documentary Trends",
                "AI and VFX",
                "Screenwriting",
                "Character Depth",
                "Cinematography",
                "Series Storytelling",
                "Franchises and Sequels",
                "Independent Cinema",
                "Festival Culture",
                "Turkish Cinema",
                "Animation Techniques",
                "Production Budgets",
                "Audience Habits",
                "Film Marketing",
                "Diversity and Representation",
                "True Story Adaptations",
                "Film Criticism"
            ],
            "Kitap": [
                "E-books vs Print",
                "Audiobook Trends",
                "Short-Form Reading",
                "Fantasy Literature",
                "Science Fiction",
                "Crime and Thriller",
                "Personal Development",
                "Current Nonfiction",
                "Translated Literature",
                "Young Adult",
                "Reading Habits",
                "Authors’ Digital Presence",
                "Book Clubs",
                "Censorship and Freedom",
                "AI in Literature",
                "Revisiting Classics",
                "Children’s Literature",
                "Graphic Novels",
                "Sustainable Publishing",
                "Cover Design"
            ],
            "Yemek": [
                "Healthy Eating",
                "Plant-Based Cuisine",
                "Fermentation",
                "Local Cuisines",
                "Zero-Waste Kitchen",
                "Quick and Easy Recipes",
                "Coffee Culture",
                "Tea Culture",
                "Street Food",
                "Homemade Bread",
                "Spices and Aroma",
                "Seasonal Eating",
                "Balanced Nutrition",
                "Food Safety",
                "Food Photography",
                "Fine Dining",
                "Vegan Desserts",
                "Child Nutrition",
                "Gourmet Snacks",
                "Meal Planning"
            ],
            "Seyahat": [
                "Sustainable Tourism",
                "Digital Nomadism",
                "Budget Travel",
                "Slow Travel",
                "Cultural Experiences",
                "Nature Routes",
                "City Getaways",
                "Gastronomy Tours",
                "Safe Travel",
                "Visa and Planning",
                "Family Travel",
                "Solo Travel",
                "Local Connections",
                "Train Journeys",
                "Vanlife and Camping",
                "Winter and Ski Routes",
                "Beach Vacations",
                "Photography Routes",
                "Travel Tech",
                "Emergency Preparedness"
            ],
            "Moda": [
                "Sustainable Fashion",
                "Second-Hand and Reuse",
                "Capsule Wardrobe",
                "Street Style",
                "Minimalist Style",
                "Color Trends",
                "Accessory Styling",
                "Athleisure",
                "Tech Fabrics",
                "Local Designers",
                "Fashion and Culture",
                "Fashion Weeks",
                "Styling Tips",
                "Size Inclusivity",
                "Ethical Production",
                "Vintage Revival",
                "Unisex Fashion",
                "Impact of Fast Fashion",
                "Upcycling",
                "Workwear"
            ],
            "Sağlık": [
                "Mental Health",
                "Sleep Hygiene",
                "Nutrition and Health",
                "Regular Exercise",
                "Immune Support",
                "Telehealth",
                "Digital Health Apps",
                "Stress Management",
                "Mindfulness",
                "Chronic Disease Management",
                "Health Literacy",
                "Women’s Health",
                "Men’s Health",
                "Child Health",
                "Senior Health",
                "Healthy Aging",
                "Wearables",
                "Health Data Privacy",
                "First Aid Awareness",
                "Preventive Health"
            ],
            "Eğitim": [
                "Hybrid Learning",
                "AI-Assisted Learning",
                "Microlearning",
                "Lifelong Learning",
                "Gamification in Education",
                "Remote Assessment",
                "Teacher Support Tools",
                "Language Learning",
                "STEM Education",
                "Coding Literacy",
                "Critical Thinking",
                "Media Literacy",
                "Project-Based Learning",
                "Career Guidance",
                "Vocational Training",
                "Special Education",
                "Accessible Education",
                "Equity in Education",
                "Exam Anxiety",
                "Study Habits"
            ],
            "Çevre": [
                "Climate Solutions",
                "Renewable Energy",
                "Carbon Footprint",
                "Circular Economy",
                "Waste Management",
                "Reducing Plastic",
                "Water Conservation",
                "Biodiversity",
                "Green Cities",
                "Public Transport",
                "Forest Protection",
                "Sustainable Agriculture",
                "Ocean Pollution",
                "Air Quality",
                "Climate Justice",
                "Green Technology",
                "Energy Efficiency",
                "Zero-Waste Living",
                "Ecotourism",
                "Nature Restoration"
            ],
            "İş Hayatı": [
                "Remote Work",
                "Hybrid Culture",
                "Performance Measurement",
                "Leadership Skills",
                "Team Communication",
                "Employee Experience",
                "Work-Life Balance",
                "Career Planning",
                "Upskilling and Reskilling",
                "HR Analytics",
                "Agile Ways of Working",
                "Project Management",
                "Startup Ecosystem",
                "Financial Literacy",
                "Entrepreneurship",
                "Sales Strategies",
                "Marketing Trends",
                "Customer Experience",
                "Business Ethics",
                "Workplace Safety"
            ]
        ]

        let categorySeedsES: [String: [String]] = [
            "Teknoloji": [
                "Agentes de IA",
                "Ética de la IA",
                "Modelos de lenguaje grandes",
                "IA en el dispositivo",
                "IA en ciberseguridad",
                "Computación cuántica",
                "Redes 5G y 6G",
                "IoT y hogares inteligentes",
                "Arquitectura nativa en la nube",
                "Zero Trust",
                "Privacidad de datos",
                "Identidad digital",
                "Casos de uso de blockchain",
                "Experiencias AR y VR",
                "Automatización y RPA",
                "Software eficiente en energía",
                "Centros de datos verdes",
                "Seguridad de código abierto",
                "Innovación fintech",
                "Robótica y cobots"
            ],
            "Sosyal": [
                "Algoritmos de redes sociales",
                "Desintoxicación digital",
                "Comunidades en línea",
                "Soledad y pertenencia",
                "Comunicación Gen Z",
                "Comunicación familiar",
                "Seguridad en redes sociales",
                "Combatir la desinformación",
                "Privacidad y compartir",
                "Etiqueta digital",
                "Voluntariado en línea",
                "Vida urbana",
                "Equilibrio vida-trabajo",
                "Migración e integración",
                "Igualdad de género",
                "Ciudadanía digital",
                "Solidaridad en crisis",
                "Economía de influencers",
                "Aprendizaje comunitario",
                "Protección de culturas locales"
            ],
            "Bilim": [
                "Modelado climático",
                "Exploración espacial",
                "Misiones a Marte",
                "Edición genética",
                "Biotecnología",
                "Neurociencia",
                "Física cuántica",
                "Materia oscura",
                "Energías renovables",
                "Química de baterías",
                "Investigación oceánica",
                "Preparación ante pandemias",
                "Tecnologías de vacunas",
                "Órganos artificiales",
                "Ciencia de materiales",
                "Nanotecnología",
                "Astrobiología",
                "Comunicación científica",
                "Ciencia de datos abierta",
                "Ética científica"
            ],
            "Sanat": [
                "Arte digital",
                "Arte con IA",
                "Arte urbano",
                "Pintura moderna",
                "Escultura contemporánea",
                "Tendencias en fotografía",
                "Tipografía y diseño gráfico",
                "Ilustración",
                "Arte performático",
                "Experiencias digitales en museos",
                "Terapia artística",
                "Cultura local y arte",
                "Minimalismo",
                "Teoría del color",
                "Arte sostenible",
                "Arte público",
                "Coleccionismo de arte",
                "Pensamiento de diseño",
                "Artesanía tradicional",
                "Educación artística"
            ],
            "Spor": [
                "Tácticas de fútbol",
                "Analítica en baloncesto",
                "Ecosistema de esports",
                "Ciencia del entrenamiento",
                "Nutrición deportiva",
                "Prevención de lesiones",
                "Psicología deportiva",
                "Tecnologías de rendimiento",
                "Cultura deportiva amateur",
                "Deportes femeninos",
                "Sostenibilidad en el deporte",
                "Carrera y maratón",
                "Técnicas de natación",
                "Tendencias de fitness",
                "Atletas jóvenes",
                "VAR y tecnología arbitral",
                "Marketing deportivo",
                "Dinámica de equipo",
                "Recuperación y sueño",
                "Deportes al aire libre"
            ],
            "Müzik": [
                "Economía del streaming",
                "Video corto y descubrimiento musical",
                "Producción musical con IA",
                "Experiencia en vivo",
                "Artistas independientes",
                "Derechos de autor",
                "Tendencias lo-fi y ambient",
                "Evolución del hip-hop",
                "Escena de música electrónica",
                "Música del mundo",
                "Experiencia de conciertos",
                "Estudio casero",
                "Mezcla y mastering",
                "Música para cine y series",
                "Colaboraciones de marca",
                "Estrategia de playlists",
                "Música y videojuegos",
                "Musicoterapia",
                "Técnicas vocales",
                "Aprender instrumentos"
            ],
            "Film": [
                "Estrategias de plataformas",
                "Cine vs digital",
                "Narrativa de cortometraje",
                "Tendencias de documental",
                "IA y VFX",
                "Guion",
                "Profundidad de personajes",
                "Cinematografía",
                "Narrativa de series",
                "Franquicias y secuelas",
                "Cine independiente",
                "Cultura de festivales",
                "Cine turco",
                "Técnicas de animación",
                "Presupuestos de producción",
                "Hábitos de audiencia",
                "Marketing cinematográfico",
                "Diversidad y representación",
                "Adaptaciones de historias reales",
                "Crítica cinematográfica"
            ],
            "Kitap": [
                "E-books vs papel",
                "Tendencias de audiolibros",
                "Lectura en formato corto",
                "Literatura fantástica",
                "Ciencia ficción",
                "Policíaco y thriller",
                "Desarrollo personal",
                "No ficción actual",
                "Literatura traducida",
                "Juvenil",
                "Hábitos de lectura",
                "Presencia digital de autores",
                "Clubes de lectura",
                "Censura y libertad",
                "IA en la literatura",
                "Releer clásicos",
                "Literatura infantil",
                "Novela gráfica",
                "Publicación sostenible",
                "Diseño de portadas"
            ],
            "Yemek": [
                "Alimentación saludable",
                "Cocina plant-based",
                "Fermentación",
                "Cocinas locales",
                "Cocina sin desperdicio",
                "Recetas rápidas",
                "Cultura del café",
                "Cultura del té",
                "Comida callejera",
                "Pan casero",
                "Especias y aromas",
                "Alimentación estacional",
                "Nutrición equilibrada",
                "Seguridad alimentaria",
                "Fotografía gastronómica",
                "Alta cocina",
                "Postres veganos",
                "Nutrición infantil",
                "Snacks gourmet",
                "Planificación de comidas"
            ],
            "Seyahat": [
                "Turismo sostenible",
                "Nomadismo digital",
                "Viajes con bajo presupuesto",
                "Viaje lento",
                "Experiencias culturales",
                "Rutas de naturaleza",
                "Escapadas urbanas",
                "Tours gastronómicos",
                "Viaje seguro",
                "Visas y planificación",
                "Viajes en familia",
                "Viajes en solitario",
                "Conexión con locales",
                "Viajes en tren",
                "Camper y camping",
                "Rutas de invierno",
                "Vacaciones de playa",
                "Rutas fotográficas",
                "Tecnología para viajar",
                "Preparación ante emergencias"
            ],
            "Moda": [
                "Moda sostenible",
                "Segunda mano y reutilización",
                "Armario cápsula",
                "Estilo urbano",
                "Estilo minimalista",
                "Tendencias de color",
                "Accesorios y estilo",
                "Athleisure",
                "Tejidos tecnológicos",
                "Diseñadores locales",
                "Moda y cultura",
                "Semanas de la moda",
                "Consejos de estilo",
                "Diversidad de tallas",
                "Producción ética",
                "Revival vintage",
                "Moda unisex",
                "Impacto de la fast fashion",
                "Upcycling",
                "Ropa de trabajo"
            ],
            "Sağlık": [
                "Salud mental",
                "Higiene del sueño",
                "Nutrición y salud",
                "Ejercicio regular",
                "Apoyo inmunológico",
                "Telemedicina",
                "Apps de salud digital",
                "Gestión del estrés",
                "Mindfulness",
                "Manejo de enfermedades crónicas",
                "Alfabetización en salud",
                "Salud de la mujer",
                "Salud del hombre",
                "Salud infantil",
                "Salud senior",
                "Envejecimiento saludable",
                "Wearables",
                "Privacidad de datos de salud",
                "Primeros auxilios",
                "Salud preventiva"
            ],
            "Eğitim": [
                "Aprendizaje híbrido",
                "Aprendizaje asistido por IA",
                "Microaprendizaje",
                "Aprendizaje continuo",
                "Gamificación en educación",
                "Evaluación remota",
                "Herramientas para docentes",
                "Aprender idiomas",
                "Educación STEM",
                "Alfabetización en programación",
                "Pensamiento crítico",
                "Alfabetización mediática",
                "Aprendizaje basado en proyectos",
                "Orientación profesional",
                "Formación profesional",
                "Educación especial",
                "Educación accesible",
                "Equidad educativa",
                "Ansiedad ante exámenes",
                "Hábitos de estudio"
            ],
            "Çevre": [
                "Soluciones climáticas",
                "Energía renovable",
                "Huella de carbono",
                "Economía circular",
                "Gestión de residuos",
                "Reducir plásticos",
                "Ahorro de agua",
                "Biodiversidad",
                "Ciudades verdes",
                "Transporte público",
                "Protección de bosques",
                "Agricultura sostenible",
                "Contaminación marina",
                "Calidad del aire",
                "Justicia climática",
                "Tecnología verde",
                "Eficiencia energética",
                "Vida sin residuos",
                "Ecoturismo",
                "Restauración de la naturaleza"
            ],
            "İş Hayatı": [
                "Trabajo remoto",
                "Cultura híbrida",
                "Medición del rendimiento",
                "Habilidades de liderazgo",
                "Comunicación de equipo",
                "Experiencia del empleado",
                "Equilibrio vida-trabajo",
                "Planificación de carrera",
                "Upskilling y reskilling",
                "Analítica de RR. HH.",
                "Trabajo ágil",
                "Gestión de proyectos",
                "Ecosistema startup",
                "Alfabetización financiera",
                "Emprendimiento",
                "Estrategias de ventas",
                "Tendencias de marketing",
                "Experiencia del cliente",
                "Ética empresarial",
                "Seguridad laboral"
            ]
        ]

        let titleTemplatesTR = [
            "%@ - Son 5 Yıl",
            "%@ - 2025/2026 Trendleri",
            "%@ - Fırsatlar ve Riskler",
            "%@ - Günlük Yaşama Etkisi",
            "%@ - Yakın Gelecek"
        ]

        let summaryTemplatesTR = [
            "%@ son 5 yılda nasıl değişti ve neden?",
            "%@ için 2025/2026 döneminde öne çıkan eğilimler neler?",
            "%@ alanında fırsatlar ve riskler neler?",
            "%@ günlük yaşamı ve alışkanlıkları nasıl etkiliyor?",
            "%@ önümüzdeki 3 yılda nereye evrilebilir?"
        ]

        let titleTemplatesEN = [
            "%@ - The Last 5 Years",
            "%@ - 2025/2026 Trends",
            "%@ - Opportunities and Risks",
            "%@ - Impact on Daily Life",
            "%@ - Near Future"
        ]

        let summaryTemplatesEN = [
            "How has %@ changed over the last five years, and why?",
            "What trends will shape %@ in 2025/2026?",
            "What are the opportunities and risks in %@?",
            "How does %@ affect daily life and habits?",
            "Where could %@ evolve in the next three years?"
        ]

        let titleTemplatesES = [
            "%@ - Últimos 5 años",
            "%@ - Tendencias 2025/2026",
            "%@ - Oportunidades y riesgos",
            "%@ - Impacto en la vida diaria",
            "%@ - Futuro cercano"
        ]

        let summaryTemplatesES = [
            "¿Cómo cambió %@ en los últimos cinco años y por qué?",
            "¿Qué tendencias marcarán %@ en 2025/2026?",
            "¿Cuáles son las oportunidades y riesgos en %@?",
            "¿Cómo impacta %@ en la vida diaria y los hábitos?",
            "¿Hacia dónde podría evolucionar %@ en los próximos tres años?"
        ]

        var generatedTopics: [TopicRealm] = []
        generatedTopics.reserveCapacity(categorySeedsTR.count * 100 * 3)

        appendTopics(
            into: &generatedTopics,
            categories: categorySeedsTR,
            titleTemplates: titleTemplatesTR,
            summaryTemplates: summaryTemplatesTR,
            language: "tr"
        )

        appendTopics(
            into: &generatedTopics,
            categories: categorySeedsEN,
            titleTemplates: titleTemplatesEN,
            summaryTemplates: summaryTemplatesEN,
            language: "en"
        )

        appendTopics(
            into: &generatedTopics,
            categories: categorySeedsES,
            titleTemplates: titleTemplatesES,
            summaryTemplates: summaryTemplatesES,
            language: "es"
        )

        return generatedTopics
    }

    private static func normalizeSeeds(_ seeds: [String], target: Int) -> [String] {
        guard !seeds.isEmpty else { return [] }
        if seeds.count >= target { return Array(seeds.prefix(target)) }

        var result: [String] = []
        result.reserveCapacity(target)
        var index = 0
        while result.count < target {
            result.append(seeds[index % seeds.count])
            index += 1
        }
        return result
    }

    private static func appendTopics(
        into list: inout [TopicRealm],
        categories: [String: [String]],
        titleTemplates: [String],
        summaryTemplates: [String],
        language: String
    ) {
        for (category, seeds) in categories {
            let normalized = normalizeSeeds(seeds, target: 20)
            for baseTitle in normalized {
                for i in 0..<5 {
                    let title = String(format: titleTemplates[i], baseTitle)
                    let summary = String(format: summaryTemplates[i], baseTitle)
                    list.append(TopicRealm(title: title, summary: summary, category: category, language: language))
                }
            }
        }
    }
}
