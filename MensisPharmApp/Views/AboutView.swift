import SwiftUI

struct AboutView: View {
    // Update these with real contact details
    let phone = "+90 XXX XXX XX XX"
    let email = "info@mensispharma.com"
    let website = "www.mensispharma.com"
    let address = "Adres bilgisi"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // Logo / Brand Header
                    ZStack {
                        LinearGradient(
                            colors: [Color.brandPrimary, Color.brandPrimary.opacity(0.7)],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                        VStack(spacing: 10) {
                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                            Text("Mensis Pharma")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Sağlıklı Yaşam Ürünleri")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.85))
                        }
                        .padding(.vertical, 36)
                    }

                    // About Text
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Hakkımızda", systemImage: "building.2.fill")
                            .font(.headline)
                            .foregroundColor(.brandPrimary)

                        Text("Mensis Pharma olarak, müşterilerimize en kaliteli vitamin, mineral ve takviye ürünlerini sunmaktayız. Sağlıklı yaşam için en iyi ürünleri seçerek kapınıza ulaştırıyoruz.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 4)
                    .padding(.horizontal)

                    // Contact Info
                    VStack(alignment: .leading, spacing: 12) {
                        Label("İletişim", systemImage: "phone.fill")
                            .font(.headline)
                            .foregroundColor(.brandPrimary)

                        ContactRow(icon: "phone.fill", color: .green, label: "Telefon", value: phone) {
                            if let url = URL(string: "tel://\(phone.filter { $0.isNumber })") {
                                UIApplication.shared.open(url)
                            }
                        }

                        ContactRow(icon: "envelope.fill", color: .brandPrimary, label: "E-posta", value: email) {
                            if let url = URL(string: "mailto:\(email)") {
                                UIApplication.shared.open(url)
                            }
                        }

                        ContactRow(icon: "globe", color: .purple, label: "Website", value: website, action: nil)

                        ContactRow(icon: "location.fill", color: .red, label: "Adres", value: address, action: nil)
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 4)
                    .padding(.horizontal)

                    // How it works
                    VStack(alignment: .leading, spacing: 14) {
                        Label("Nasıl Sipariş Verilir?", systemImage: "questionmark.circle.fill")
                            .font(.headline)
                            .foregroundColor(.brandPrimary)

                        StepRow(number: "1", text: "Ürünler sayfasından istediğiniz ürünleri sepete ekleyin.")
                        StepRow(number: "2", text: "Sepetinizi gözden geçirin ve 'Sipariş Ver' butonuna basın.")
                        StepRow(number: "3", text: "Teslimat bilgilerinizi girin ve siparişi gönderin.")
                        StepRow(number: "4", text: "Ekibimiz size en kısa sürede fiyat ve kargo bilgisiyle dönüş yapar.")
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 4)
                    .padding(.horizontal)

                    // App version
                    Text("Mensis Pharma v1.0")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
                }
                .padding(.top, 0)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Hakkımızda")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContactRow: View {
    let icon: String
    let color: Color
    let label: String
    let value: String
    let action: (() -> Void)?

    var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                    .frame(width: 36, height: 36)
                    .background(color.opacity(0.12))
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 1) {
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(value)
                        .font(.subheadline)
                        .foregroundColor(action != nil ? .brandPrimary : .primary)
                }
                Spacer()
                if action != nil {
                    Image(systemName: "arrow.up.right.circle")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(action == nil)
    }
}

struct StepRow: View {
    let number: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 26, height: 26)
                .background(Color.brandPrimary)
                .clipShape(Circle())
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
                .lineSpacing(3)
            Spacer()
        }
    }
}
