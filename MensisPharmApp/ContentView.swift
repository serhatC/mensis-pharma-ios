import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cart: CartViewModel

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Ürünler", systemImage: "pills.fill")
                }

            CartView()
                .tabItem {
                    Label("Sepet", systemImage: "cart.fill")
                }
                .badge(cart.totalItemCount > 0 ? "\(cart.totalItemCount)" : nil)

            AboutView()
                .tabItem {
                    Label("Hakkımızda", systemImage: "info.circle.fill")
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
