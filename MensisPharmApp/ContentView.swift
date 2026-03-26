import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cart: CartViewModel
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(lang.s("Ürünler", "Products"), systemImage: "pills.fill")
                }

            CartView()
                .tabItem {
                    Label(lang.s("Sepet", "Cart"), systemImage: "cart.fill")
                }
                .badge(cart.totalItemCount > 0 ? "\(cart.totalItemCount)" : nil)

            AboutView()
                .tabItem {
                    Label(lang.s("Hakkımızda", "About"), systemImage: "info.circle.fill")
                }
        }
        .tint(Color.brandPrimary)
    }
}

// MARK: - Brand Color Extension
extension Color {
    static let brandPrimary = Color(hex: "1B6CA8")
    static let brandSecondary = Color(hex: "27AE60")
}
