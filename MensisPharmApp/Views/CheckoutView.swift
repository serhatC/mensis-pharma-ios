import SwiftUI
import MessageUI

struct CheckoutView: View {
    @EnvironmentObject var cart: CartViewModel
    @Environment(\.dismiss) var dismiss

    @State private var showMailCompose = false
    @State private var showMailtoFallback = false
    @State private var showSuccess = false
    @State private var showValidationError = false
    @State private var validationMessage = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Info Banner
                HStack(spacing: 10) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.brandPrimary)
                    Text("Bilgilerinizi girdikten sonra sipariş e-postası hazırlanacak ve tarafımıza iletilecektir.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(14)
                .background(Color.brandPrimary.opacity(0.08))
                .cornerRadius(12)

                // Order summary
                orderSummarySection

                // Customer info form
                formSection

                // Submit button
                submitButton

                Spacer(minLength: 40)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Sipariş Bilgileri")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Eksik Bilgi", isPresented: $showValidationError) {
            Button("Tamam", role: .cancel) {}
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
            Label("Sipariş Özeti", systemImage: "cart.fill")
                .font(.headline)
                .foregroundColor(.brandPrimary)

            ForEach(cart.items) { item in
                HStack {
                    Text("• \(item.product.name)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(item.quantity) adet")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Divider()

            HStack {
                Text("Toplam")
                    .fontWeight(.semibold)
                Spacer()
                Text("\(cart.totalItemCount) ürün")
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
            Label("Müşteri Bilgileri", systemImage: "person.fill")
                .font(.headline)
                .foregroundColor(.brandPrimary)

            FormField(title: "Ad Soyad *", icon: "person", placeholder: "Adınız ve soyadınız",
                      text: $cart.customerInfo.name)

            FormField(title: "Telefon *", icon: "phone", placeholder: "05XX XXX XX XX",
                      text: $cart.customerInfo.phone, keyboard: .phonePad)

            FormField(title: "E-posta", icon: "envelope", placeholder: "ornek@email.com",
                      text: $cart.customerInfo.email, keyboard: .emailAddress)

            FormField(title: "Şehir *", icon: "building.2", placeholder: "İstanbul",
                      text: $cart.customerInfo.city)

            FormField(title: "İlçe", icon: "map", placeholder: "Kadıköy",
                      text: $cart.customerInfo.district)

            VStack(alignment: .leading, spacing: 6) {
                Label("Teslimat Adresi *", systemImage: "house.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                TextEditor(text: $cart.customerInfo.address)
                    .frame(minHeight: 80)
                    .padding(10)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .overlay(alignment: .topLeading) {
                        if cart.customerInfo.address.isEmpty {
                            Text("Tam teslimat adresinizi giriniz...")
                                .foregroundColor(.secondary.opacity(0.6))
                                .padding(14)
                                .allowsHitTesting(false)
                        }
                    }
            }

            VStack(alignment: .leading, spacing: 6) {
                Label("Notlar", systemImage: "note.text")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                TextEditor(text: $cart.customerInfo.notes)
                    .frame(minHeight: 60)
                    .padding(10)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .overlay(alignment: .topLeading) {
                        if cart.customerInfo.notes.isEmpty {
                            Text("Özel istekleriniz veya notlarınız...")
                                .foregroundColor(.secondary.opacity(0.6))
                                .padding(14)
                                .allowsHitTesting(false)
                        }
                    }
            }

            Text("* zorunlu alanlar")
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
                Text("Siparişi Gönder")
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
            validationMessage = "Lütfen Ad Soyad, Telefon, Şehir ve Adres alanlarını doldurunuz."
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
            validationMessage = "Bu cihazda e-posta uygulaması bulunamadı. Lütfen \(cart.orderEmail) adresine manuel olarak sipariş iletin."
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
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
        }
    }
}
