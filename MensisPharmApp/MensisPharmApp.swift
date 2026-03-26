import SwiftUI

@main
struct MensisPharmApp: App {
    @StateObject private var cart = CartViewModel()
    @StateObject private var store = ProductStore()
    @StateObject private var lang = LanguageManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cart)
                .environmentObject(store)
                .environmentObject(lang)
        }
    }
}
