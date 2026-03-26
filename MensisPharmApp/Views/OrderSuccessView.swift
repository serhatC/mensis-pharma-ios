import SwiftUI

struct OrderSuccessView: View {
    @EnvironmentObject var lang: LanguageManager

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            ZStack {
                Circle().fill(Color.green.opacity(0.12)).frame(width: 130, height: 130)
                Circle().fill(Color.green.opacity(0.2)).frame(width: 100, height: 100)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 64))
                    .foregroundColor(.green)
            }

            VStack(spacing: 12) {
                Text(lang.s("Siparişiniz Alındı!", "Order Received!"))
                    .font(.title)
                    .fontWeight(.bold)
                Text(lang.s(
                    "Siparişiniz başarıyla iletildi. En kısa sürede tarafınıza dönüş yapılacaktır.",
                    "Your order has been successfully submitted. We will get back to you shortly."
                ))
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            }

            VStack(spacing: 12) {
                InfoCard(
                    icon: "clock.fill", color: .orange,
                    title: lang.s("İşlem Süresi", "Processing Time"),
                    description: lang.s(
                        "Siparişiniz 24 saat içinde değerlendirilecektir.",
                        "Your order will be reviewed within 24 hours."
                    )
                )
                InfoCard(
                    icon: "phone.fill", color: .brandPrimary,
                    title: lang.s("İletişim", "Contact"),
                    description: lang.s(
                        "Sorularınız için bizimle iletişime geçebilirsiniz.",
                        "Feel free to contact us for any questions."
                    )
                )
                InfoCard(
                    icon: "shippingbox.fill", color: .purple,
                    title: lang.s("Kargo Bilgisi", "Shipping Info"),
                    description: lang.s(
                        "Onay sonrasında kargo bilgileriniz paylaşılacaktır.",
                        "Shipping details will be shared after confirmation."
                    )
                )
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.dismiss(animated: true)
                }
            }) {
                Text(lang.s("Ana Sayfaya Dön", "Return to Home"))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .padding(.horizontal)
            }

            Spacer(minLength: 30)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
    }
}

struct InfoCard: View {
    let icon: String
    let color: Color
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.12))
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.subheadline).fontWeight(.semibold)
                Text(description).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4)
    }
}
