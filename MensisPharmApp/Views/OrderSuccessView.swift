import SwiftUI

struct OrderSuccessView: View {
    @EnvironmentObject var cart: CartViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            // Success animation
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.12))
                    .frame(width: 130, height: 130)
                Circle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 100, height: 100)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 64))
                    .foregroundColor(.green)
            }

            VStack(spacing: 12) {
                Text("Siparişiniz Alındı!")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Siparişiniz başarıyla iletildi. En kısa sürede tarafınıza dönüş yapılacaktır.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
            }

            // Info cards
            VStack(spacing: 12) {
                InfoCard(icon: "clock.fill", color: .orange,
                         title: "İşlem Süresi",
                         description: "Siparişiniz 24 saat içinde değerlendirilecektir.")
                InfoCard(icon: "phone.fill", color: .brandPrimary,
                         title: "İletişim",
                         description: "Sorularınız için bizimle iletişime geçebilirsiniz.")
                InfoCard(icon: "shippingbox.fill", color: .purple,
                         title: "Kargo Bilgisi",
                         description: "Onay sonrasında kargo bilgileriniz paylaşılacaktır.")
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                // Pop to root - navigate back to home
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.dismiss(animated: true)
                }
            }) {
                Text("Ana Sayfaya Dön")
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
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4)
    }
}
