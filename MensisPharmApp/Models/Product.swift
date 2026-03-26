import Foundation
import SwiftUI

struct Product: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let details: String
    let unit: String
    let categoryId: String
    var isAvailable: Bool
    let imageSystemName: String
    /// Optional: name of an image in Assets.xcassets (e.g. "krill_complex")
    let imageName: String?

    init(id: String, name: String, description: String, details: String,
         unit: String, categoryId: String, isAvailable: Bool = true,
         imageSystemName: String = "pill.fill", imageName: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.details = details
        self.unit = unit
        self.categoryId = categoryId
        self.isAvailable = isAvailable
        self.imageSystemName = imageSystemName
        self.imageName = imageName
    }

    static func == (lhs: Product, rhs: Product) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

struct Category: Identifiable {
    let id: String
    let name: String
    let icon: String
    let colorHex: String
    var products: [Product]

    var color: Color {
        Color(hex: colorHex)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
