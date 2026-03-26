import SwiftUI

struct AboutView: View {
    @EnvironmentObject var lang: LanguageManager

    let phone = "+90 (850) 302 5465"
    let email = "info@mensispharma.com"
    let website = "www.mensispharma.com"
    let address = "Güzelyalı Mh. 81029 Sk. No:4/B 01170 Çukurova/Adana"

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
                            if UIImage(named: "logo") != nil {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 64)
                            } else {
                                Image(systemName: "cross.case.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                            }
                            Text("Mensis Pharma")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text(lang.s("Sağlıklı Yaşam Ürünleri", "Health & Wellness Products"))
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.85))
                        }
                        .padding(.vertical, 36)
                    }

                    // About Text
                    VStack(alignment: .leading, spacing: 10) {
                        Label(lang.s("Hakkımızda", "About Us"), systemImage: "building.2.fill")
                            .font(.headline).foregroundColor(.brandPrimary)
                        Text(lang.s(
                            "Mensis Pharma olarak, müşterilerimize en kaliteli vitamin, mineral ve takviye ürünlerini sunmaktayız. Sağlıklı yaşam için en iyi ürünleri seçerek kapınıza ulaştırıyoruz.",
                            "At Mensis Pharma, we provide our customers with the highest quality vitamins, minerals, and dietary supplements. We select the best products for a healthy life and deliver them to your door."
                        ))
                        .font(.body).foregroundColor(.secondary).lineSpacing(4)
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 4)
                    .padding(.horizontal)

                    // Contact
                    VStack(alignment: .leading, spacing: 12) {
                        Label(lang.s("İletişim", "Contact"), systemImage: "phone.fill")
                            .font(.headline).foregroundColor(.brandPrimary)

                        ContactRow(icon: "phone.fill", color: .green,
                                   label: lang.s("Telefon", "Phone"), value: phone) {
                            if let url = URL(string: "tel://\(phone.filter { $0.isNumber })") {
                                UIApplication.shared.open(url)
                            }
                        }
                        ContactRow(icon: "envelope.fill", color: .brandPrimary,
                                   label: lang.s("E-posta", "Email"), value: email) {
                            if let url = URL(string: "mailto:\(email)") {
                                UIApplication.shared.open(url)
                            }
                        }
                        ContactRow(icon: "globe", color: .purple,
                                   label: lang.s("Website", "Website"), value: website, action: nil)
                        ContactRow(icon: "location.fill", color: .red,
                                   label: lang.s("Adres", "Address"), value: address, action: nil)
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 4)
                    .padding(.horizontal)

                    // How to Order
                    VStack(alignment: .leading, spacing: 14) {
                        Label(lang.s("Nasıl Sipariş Verilir?", "How to Order?"), systemImage: "questionmark.circle.fill")
                            .font(.headline).foregroundColor(.brandPrimary)

                        StepRow(number: "1", text: lang.s(
                            "Ürünler sayfasından istediğiniz ürünleri sepete ekleyin.",
                            "Browse the Products tab and add items to your cart."
                        ))
                        StepRow(number: "2", text: lang.s(
                            "Sepetinizi gözden geçirin ve 'Sipariş Ver' butonuna basın.",
                            "Review your cart and tap 'Place Order'."
                        ))
                        StepRow(number: "3", text: lang.s(
                            "Teslimat bilgilerinizi girin ve siparişi gönderin.",
                            "Enter your delivery details and send the order."
                        ))
                        StepRow(number: "4", text: lang.s(
                            "Ekibimiz size en kısa sürede fiyat ve kargo bilgisiyle dönüş yapar.",
                            "Our team will reply with pricing and shipping details as soon as possible."
                        ))
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 4)
                    .padding(.horizontal)

                    Text("Mensis Pharma v1.0")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(lang.s("Hakkımızda", "About"))
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
                    Text(label).font(.caption).foregroundColor(.secondary)
                    Text(value).font(.subheadline)
                        .foregroundColor(action != nil ? .brandPrimary : .primary)
                }
                Spacer()
                if action != nil {
                    Image(systemName: "arrow.up.right.circle").foregroundColor(.secondary).font(.caption)
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
                .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                .frame(width: 26, height: 26)
                .background(Color.brandPrimary)
                .clipShape(Circle())
            Text(text).font(.subheadline).foregroundColor(.primary).lineSpacing(3)
            Spacer()
        }
    }
}
