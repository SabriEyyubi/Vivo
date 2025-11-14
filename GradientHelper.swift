import UIKit

// MARK: - Tek Fonksiyonla Gradient Oluşturma ve Ayarlama
func createCallShieldGradient(for view: UIView) {
    // Mevcut gradient layer'ları temizle
    view.layer.sublayers?.removeAll { $0 is CAGradientLayer }
    
    // Renkler - istediğiniz gibi değiştirin
    let linearStart = UIColor(red: 0/255, green: 225/255, blue: 75/255, alpha: 1.0)  // Yeşil başlangıç
    let linearEnd = UIColor(red: 0/255, green: 175/255, blue: 75/255, alpha: 1.0)    // Koyu yeşil bitiş
    
    // Sadece Linear Gradient kullan (radial gradient sorun çıkarıyor)
    let linearGradient = CAGradientLayer()
    linearGradient.colors = [linearStart.cgColor, linearEnd.cgColor]
    linearGradient.locations = [0, 1]
    linearGradient.startPoint = CGPoint(x: 0.5, y: 0)
    linearGradient.endPoint = CGPoint(x: 0.5, y: 1)
    linearGradient.frame = view.bounds
    
    view.layer.insertSublayer(linearGradient, at: 0)
    
    // Radial gradient için Core Graphics kullan
    let radialLayer = CALayer()
    radialLayer.frame = view.bounds
    radialLayer.contents = createRadialGradientImage(size: view.bounds.size)
    
    view.layer.insertSublayer(radialLayer, at: 1)
}

// MARK: - Core Graphics ile Radial Gradient
func createRadialGradientImage(size: CGSize) -> CGImage? {
    let renderer = UIGraphicsImageRenderer(size: size)
    
    return renderer.image { context in
        let cgContext = context.cgContext
        
        // Renkler
        let centerColor = UIColor(red: 7/255, green: 232/255, blue: 83/255, alpha: 0.55)
        let edgeColor = UIColor(red: 19/255, green: 139/255, blue: 60/255, alpha: 0.0)
        
        // Merkez noktası (view'ın %28'i yukarıda)
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.28)
        
        // Yarıçap - view'ın tamamını kaplayacak kadar büyük
        let radius = max(size.width, size.height) * 1.2
        
        // Radial gradient oluştur
        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                   colors: [centerColor.cgColor, edgeColor.cgColor] as CFArray,
                                   locations: [0, 1]) {
            cgContext.drawRadialGradient(
                gradient,
                startCenter: center,
                startRadius: 0,
                endCenter: center,
                endRadius: radius,
                options: []
            )
        }
    }.cgImage
}

// MARK: - Renk Değiştirme Fonksiyonu
func updateGradientColors(for view: UIView, 
                         linearStart: UIColor? = nil,
                         linearEnd: UIColor? = nil,
                         radialCenter: UIColor? = nil,
                         radialEdge: UIColor? = nil) {
    
    // Mevcut gradient layer'ları bul
    guard let linearLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer,
          let radialLayer = view.layer.sublayers?.last(where: { $0 is CAGradientLayer }) as? CAGradientLayer else {
        return
    }
    
    // Linear gradient renklerini güncelle
    if let start = linearStart, let end = linearEnd {
        linearLayer.colors = [start.cgColor, end.cgColor]
    }
    
    // Radial gradient renklerini güncelle
    if let center = radialCenter, let edge = radialEdge {
        radialLayer.colors = [center.cgColor, edge.cgColor]
    }
}

// MARK: - Kullanım
/*
// ViewController'da:
override func viewDidLoad() {
    super.viewDidLoad()
    createCallShieldGradient(for: titleView)
}

override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    createCallShieldGradient(for: titleView)
}
*/