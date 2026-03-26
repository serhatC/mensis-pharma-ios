import Foundation
import SwiftUI

struct Product: Identifiable, Hashable {
    let id: String
    let name: String        // Turkish (default)
    let nameEN: String
    let description: String // Turkish (default)
    let descriptionEN: String
    let details: String     // Turkish (default)
    let detailsEN: String
    let unit: String
    let categoryId: String
    var isAvailable: Bool
    let imageSystemName: String
    let imageName: String?

    init(id: String,
         name: String, nameEN: String,
         description: String, descriptionEN: String,
         details: String, detailsEN: String,
         unit: String, categoryId: String,
         isAvailable: Bool = true,
         imageSystemName: String = "pill.fill",
         imageName: String? = nil) {
        self.id = id
        self.name = name
        self.nameEN = nameEN
        self.description = description
        self.descriptionEN = descriptionEN
        self.details = details
        self.detailsEN = detailsEN
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
    let name: String    // Turkish (default)
    let nameEN: String
    let icon: String
    let colorHex: String
    var products: [Product]
    let imageName: String?

    init(id: String, name: String, nameEN: String, icon: String,
         colorHex: String, products: [Product], imageName: String? = nil) {
        self.id = id
        self.name = name
        self.nameEN = nameEN
        self.icon = icon
        self.colorHex = colorHex
        self.products = products
        self.imageName = imageName
    }

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
