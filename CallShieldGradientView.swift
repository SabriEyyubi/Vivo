import UIKit

final class CallShieldGradientView: UIView {

    // MARK: - Ayarlandabilir Özellikler
    var linearStartColor: UIColor = UIColor(hex: 0x00E14B) {
        didSet { setNeedsDisplay() }
    }
    
    var linearEndColor: UIColor = UIColor(hex: 0x00AF4B) {
        didSet { setNeedsDisplay() }
    }
    
    var radialCenterColor: UIColor = UIColor(hex: 0x07E853).withAlphaComponent(0.55) {
        didSet { setNeedsDisplay() }
    }
    
    var radialEdgeColor: UIColor = UIColor(hex: 0x138B3C).withAlphaComponent(0.0) {
        didSet { setNeedsDisplay() }
    }
    
    var radialCenterY: CGFloat = 0.28 {
        didSet { setNeedsDisplay() }
    }
    
    var radialRadiusMultiplier: CGFloat = 0.7 {
        didSet { setNeedsDisplay() }
    }
    
    var enableRadialGradient: Bool = true {
        didSet { setNeedsDisplay() }
    }

    // CATiledLayer yerine CALayer kullan
    override class var layerClass: AnyClass {
        return CALayer.self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        // Context'i temizle
        ctx.clear(rect)

        // 1) LINEAR GRADIENT (üst -> alt)
        if let lg = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                               colors: [linearStart, linearEnd] as CFArray,
                               locations: [0, 1]) {
            let start = CGPoint(x: rect.midX, y: rect.minY)
            let end   = CGPoint(x: rect.midX, y: rect.maxY)
            ctx.drawLinearGradient(lg, start: start, end: end, options: [])
        }

        // 2) RADIAL GRADIENT (merkez parlama)
        if let rg = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                               colors: [radialCenter, radialEdge] as CFArray,
                               locations: [0, 1]) {

            // Merkez: görselindeki gibi biraz yukarı
            let center = CGPoint(x: rect.midX, y: rect.height * 0.28)

            // Yarıçap: view'ın köşegeninin yarısı kadar (daha güvenli)
            let maxDimension = max(rect.width, rect.height)
            let radius = maxDimension * 0.7 // 1.2 yerine 0.7 kullan

            ctx.drawRadialGradient(
                rg,
                startCenter: center, 
                startRadius: 0,
                endCenter: center,   
                endRadius: radius,
                options: [] // Gereksiz seçenekleri kaldır
            )
        }
    }
}

// UIColor extension for hex colors
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
