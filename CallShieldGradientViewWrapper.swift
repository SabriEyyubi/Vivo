import SwiftUI
import UIKit

// MARK: - UIViewRepresentable Wrapper
struct CallShieldGradientViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> CallShieldGradientView {
        let gradientView = CallShieldGradientView()
        return gradientView
    }
    
    func updateUIView(_ uiView: CallShieldGradientView, context: Context) {
        // View güncellendiğinde burada gerekli işlemleri yapabilirsiniz
        uiView.setNeedsDisplay()
    }
}

// MARK: - SwiftUI View Modifier
struct CallShieldGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            CallShieldGradientViewWrapper()
                .ignoresSafeArea()
            
            content
        }
    }
}

// MARK: - View Extension
extension View {
    func callShieldGradient() -> some View {
        self.modifier(CallShieldGradientModifier())
    }
}

// MARK: - Kullanım Örnekleri
struct GradientExampleView: View {
    var body: some View {
        VStack {
            Text("Call Shield Gradient")
                .font(.title)
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            
            Text("Bu metin gradient üzerinde görünüyor")
                .foregroundColor(.white)
                .padding()
        }
        .callShieldGradient() // Gradient'ı arka plan olarak ekle
    }
}

// MARK: - Preview
#Preview {
    GradientExampleView()
}


