import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var customerInfo = CustomerInfo()
    @Published var orderSent: Bool = false
    @Published var showMailError: Bool = false

    // MARK: - Order email address — change this to your actual email
    let orderEmail = "siparis@mensispharma.com"
    let companyName = "Mensis Pharma"

    var totalItemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var isEmpty: Bool { items.isEmpty }

    // MARK: - Cart Operations

    func add(_ product: Product) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product))
        }
    }

    func remove(_ product: Product) {
        items.removeAll { $0.id == product.id }
    }

    func decreaseQuantity(of product: Product) {
        guard let index = items.firstIndex(where: { $0.id == product.id }) else { return }
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }

    func quantity(of product: Product) -> Int {
        items.first(where: { $0.id == product.id })?.quantity ?? 0
    }

    func isInCart(_ product: Product) -> Bool {
        items.contains(where: { $0.id == product.id })
    }

    func clearCart() {
        items.removeAll()
        customerInfo = CustomerInfo()
    }

    // MARK: - Email Composition

    func buildEmailSubject() -> String {
        "Yeni Sipariş - \(customerInfo.name)"
    }

    func buildEmailBody() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "tr_TR")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: Date())

        var body = """
        ════════════════════════════════
        🛒 YENİ SİPARİŞ - \(companyName.uppercased())
        ════════════════════════════════
        📅 Tarih: \(date)

        ── MÜŞTERİ BİLGİLERİ ──────────
        👤 Ad Soyad : \(customerInfo.name)
        📞 Telefon  : \(customerInfo.phone)
        📧 E-posta  : \(customerInfo.email.isEmpty ? "Belirtilmedi" : customerInfo.email)
        🏙️ Şehir    : \(customerInfo.city)\(customerInfo.district.isEmpty ? "" : " / \(customerInfo.district)")
        🏠 Adres    : \(customerInfo.address)

        ── SİPARİŞ DETAYLARI ───────────
        """

        for item in items {
            body += "\n  • \(item.product.name) — \(item.quantity) \(item.quantity > 1 ? "adet" : "adet")  [\(item.product.unit)]"
        }

        body += "\n\n  Toplam Ürün Çeşidi: \(items.count)"
        body += "\n  Toplam Adet       : \(totalItemCount)"

        if !customerInfo.notes.isEmpty {
            body += "\n\n── NOTLAR ──────────────────────\n  \(customerInfo.notes)"
        }

        body += """


        ════════════════════════════════
        Bu sipariş Mensis Pharma mobil uygulaması aracılığıyla iletilmiştir.
        Lütfen müşteriye fiyat bilgisi ve kargo detayları için dönüş yapınız.
        ════════════════════════════════
        """

        return body
    }

    func mailtoURL() -> URL? {
        let subject = buildEmailSubject().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let body = buildEmailBody().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "mailto:\(orderEmail)?subject=\(subject)&body=\(body)"
        return URL(string: urlString)
    }
}
