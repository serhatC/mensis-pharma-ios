import SwiftUI

@main
struct MensisPharmApp: App {
    @StateObject private var cart = CartViewModel()
    @StateObject private var store = ProductStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cart)
                .environmentObject(store)
        }
    }
}
