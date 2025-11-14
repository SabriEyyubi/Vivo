import UIKit

// MARK: - Basit Test Fonksiyonu
func createSimpleGradient(for view: UIView) {
    // Mevcut gradient layer'ları temizle
    view.layer.sublayers?.removeAll { $0 is CAGradientLayer }
    
    // Sadece Linear Gradient
    let gradient = CAGradientLayer()
    gradient.colors = [
        UIColor(red: 0/255, green: 225/255, blue: 75/255, alpha: 1.0).cgColor,  // Açık yeşil
        UIColor(red: 0/255, green: 175/255, blue: 75/255, alpha: 1.0).cgColor   // Koyu yeşil
    ]
    gradient.locations = [0, 1]
    gradient.startPoint = CGPoint(x: 0.5, y: 0)
    gradient.endPoint = CGPoint(x: 0.5, y: 1)
    gradient.frame = view.bounds
    
    view.layer.insertSublayer(gradient, at: 0)
}

// MARK: - Debug Fonksiyonu
func debugGradientView(_ view: UIView) {
    print("View bounds: \(view.bounds)")
    print("View frame: \(view.frame)")
    print("View clipsToBounds: \(view.clipsToBounds)")
    print("View backgroundColor: \(view.backgroundColor?.description ?? "nil")")
    
    for (index, layer) in view.layer.sublayers?.enumerated() ?? [].enumerated() {
        if let gradientLayer = layer as? CAGradientLayer {
            print("Gradient layer \(index): frame = \(gradientLayer.frame)")
        }
    }
}
