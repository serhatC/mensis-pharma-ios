import SwiftUI
import MessageUI

struct CheckoutView: View {
    @EnvironmentObject var cart: CartViewModel
    @EnvironmentObject var lang: LanguageManager
    @Environment(\.dismiss) var dismiss

    @State private var showMailCompose = false
    @State private var showSuccess = false
    @State private var showValidationError = false
    @State private var validationMessage = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Info Banner
                HStack(spacing: 10) {
                    Image(systemName: "info.circle.fill").foregroundColor(.brandPrimary)
                    Text(lang.s(
                        "Bilgilerinizi girdikten sonra sipariş e-postası hazırlanacak ve tarafımıza iletilecektir.",
                        "After filling in your details, an order email will be prepared and sent to us."
                    ))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(14)
                .background(Color.brandPrimary.opacity(0.08))
                .cornerRadius(12)

                orderSummarySection
                formSection
                submitButton

                Spacer(minLength: 40)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(lang.s("Sipariş Bilgileri", "Order Details"))
        .navigationBarTitleDisplayMode(.inline)
        .alert(lang.s("Eksik Bilgi", "Missing Information"), isPresented: $showValidationError) {
            Button(lang.s("Tamam", "OK"), role: .cancel) {}
        } message: {
            Text(validationMessage)
        }
        .sheet(isPresented: $showMailCompose) {
            MailComposeView(
                toAddress: cart.orderEmail,
                subject: cart.buildEmailSubject(),
                body: cart.buildEmailBody()
            ) { sent in
                if sent {
                    cart.clearCart()
                    showSuccess = true
                }
            }
        }
        .navigationDestination(isPresented: $showSuccess) {
            OrderSuccessView()
        }
    }

    // MARK: - Order Summary

    private var orderSummarySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(lang.s("Sipariş Özeti", "Order Summary"), systemImage: "cart.fill")
                .font(.headline)
                .foregroundColor(.brandPrimary)

            ForEach(cart.items) { item in
                HStack {
                    Text("• \(item.product.name)")
                        .font(.subheadline)
                    Spacer()
                    Text("\(item.quantity) \(lang.s("adet", "pcs"))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Divider()

            HStack {
                Text(lang.s("Toplam", "Total")).fontWeight(.semibold)
                Spacer()
                Text("\(cart.totalItemCount) \(lang.s("ürün", "items"))")
                    .fontWeight(.semibold)
                    .foregroundColor(.brandPrimary)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4)
    }

    // MARK: - Form

    private var formSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(lang.s("Müşteri Bilgileri", "Customer Information"), systemImage: "person.fill")
                .font(.headline)
                .foregroundColor(.brandPrimary)

            FormField(title: lang.s("Ad Soyad *", "Full Name *"),
                      icon: "person", placeholder: lang.s("Adınız ve soyadınız", "Your full name"),
                      text: $cart.customerInfo.name)

            FormField(title: lang.s("Telefon *", "Phone *"),
                      icon: "phone", placeholder: lang.s("05XX XXX XX XX", "+1 (XXX) XXX-XXXX"),
                      text: $cart.customerInfo.phone, keyboard: .phonePad)

            FormField(title: lang.s("E-posta", "Email"),
                      icon: "envelope", placeholder: lang.s("ornek@email.com", "example@email.com"),
                      text: $cart.customerInfo.email, keyboard: .emailAddress)

            FormField(title: lang.s("Şehir *", "City *"),
                      icon: "building.2", placeholder: lang.s("İstanbul", "New York"),
                      text: $cart.customerInfo.city)

            FormField(title: lang.s("İlçe", "District / State"),
                      icon: "map", placeholder: lang.s("Kadıköy", "Manhattan"),
                      text: $cart.customerInfo.district)

            // Address
            VStack(alignment: .leading, spacing: 6) {
                Label(lang.s("Teslimat Adresi *", "Delivery Address *"), systemImage: "house.fill")
                    .font(.subheadline).foregroundColor(.secondary)
                TextEditor(text: $cart.customerInfo.address)
                    .frame(minHeight: 80)
                    .padding(10)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 1))
                    .overlay(alignment: .topLeading) {
                        if cart.customerInfo.address.isEmpty {
                            Text(lang.s("Tam teslimat adresinizi giriniz...", "Enter your full delivery address..."))
                                .foregroundColor(.secondary.opacity(0.6))
                                .padding(14)
                                .allowsHitTesting(false)
                        }
                    }
            }

            // Notes
            VStack(alignment: .leading, spacing: 6) {
                Label(lang.s("Notlar", "Notes"), systemImage: "note.text")
                    .font(.subheadline).foregroundColor(.secondary)
                TextEditor(text: $cart.customerInfo.notes)
                    .frame(minHeight: 60)
                    .padding(10)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 1))
                    .overlay(alignment: .topLeading) {
                        if cart.customerInfo.notes.isEmpty {
                            Text(lang.s("Özel istekleriniz veya notlarınız...", "Special requests or notes..."))
                                .foregroundColor(.secondary.opacity(0.6))
                                .padding(14)
                                .allowsHitTesting(false)
                        }
                    }
            }

            Text(lang.s("* zorunlu alanlar", "* required fields"))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4)
    }

    // MARK: - Submit

    private var submitButton: some View {
        Button(action: submitOrder) {
            HStack {
                Image(systemName: "paperplane.fill")
                Text(lang.s("Siparişi Gönder", "Send Order"))
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(14)
        }
    }

    private func submitOrder() {
        guard cart.customerInfo.isValid else {
            validationMessage = lang.s(
                "Lütfen Ad Soyad, Telefon, Şehir ve Adres alanlarını doldurunuz.",
                "Please fill in Full Name, Phone, City and Address fields."
            )
            showValidationError = true
            return
        }
        if MailComposeView.canSendMail {
            showMailCompose = true
        } else if let url = cart.mailtoURL(), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            cart.clearCart()
            showSuccess = true
        } else {
            validationMessage = lang.s(
                "Bu cihazda e-posta uygulaması bulunamadı. Lütfen \(cart.orderEmail) adresine manuel olarak sipariş iletin.",
                "No mail app found on this device. Please send your order manually to \(cart.orderEmail)."
            )
            showValidationError = true
        }
    }
}

struct FormField: View {
    let title: String
    let icon: String
    let placeholder: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(title, systemImage: icon)
                .font(.subheadline)
                .foregroundColor(.secondary)
            TextField(placeholder, text: $text)
                .keyboardType(keyboard)
                .autocorrectionDisabled()
                .padding(12)
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 1))
        }
    }
}
