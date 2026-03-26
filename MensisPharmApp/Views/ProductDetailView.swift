import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cart: CartViewModel
    @State private var addedAnimation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // Header
                ZStack {
                    LinearGradient(
                        colors: [Color.brandPrimary, Color.brandPrimary.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    VStack(spacing: 12) {
                        Image(systemName: product.imageSystemName)
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 4)
                        if !product.isAvailable {
                            Text("Stokta Yok")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.red.opacity(0.8))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical, 36)
                }

                VStack(alignment: .leading, spacing: 20) {

                    // Name & Unit
                    VStack(alignment: .leading, spacing: 6) {
                        Text(product.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        HStack {
                            Image(systemName: "shippingbox.fill")
                                .font(.caption)
                                .foregroundColor(.brandPrimary)
                            Text(product.unit)
                                .font(.subheadline)
                                .foregroundColor(.brandPrimary)
                        }
                        Text(product.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Divider()

                    // Details
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Ürün Detayları", systemImage: "info.circle.fill")
                            .font(.headline)
                            .foregroundColor(.brandPrimary)
                        Text(product.details)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }

                    Divider()

                    // Price note
                    HStack {
                        Image(systemName: "tag.fill")
                            .foregroundColor(.orange)
                        Text("Fiyat bilgisi için sipariş veriniz. En kısa sürede dönüş yapılacaktır.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(14)
                    .background(Color.orange.opacity(0.08))
                    .cornerRadius(12)

                    // Add to cart button
                    if product.isAvailable {
                        if cart.isInCart(product) {
                            HStack(spacing: 16) {
                                Button(action: { cart.decreaseQuantity(of: product) }) {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.system(size: 36))
                                        .foregroundColor(.secondary)
                                }
                                Text("\(cart.quantity(of: product))")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(minWidth: 40)
                                Button(action: { cart.add(product) }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 36))
                                        .foregroundColor(.brandPrimary)
                                }
                                Spacer()
                                Button(action: { cart.remove(product) }) {
                                    Label("Çıkar", systemImage: "trash")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.06), radius: 4)
                        } else {
                            Button(action: {
                                cart.add(product)
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                    addedAnimation = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    addedAnimation = false
                                }
                            }) {
                                HStack {
                                    Image(systemName: addedAnimation ? "checkmark.circle.fill" : "cart.badge.plus")
                                    Text(addedAnimation ? "Sepete Eklendi!" : "Sepete Ekle")
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(addedAnimation ? Color.green : Color.brandPrimary)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                                .scaleEffect(addedAnimation ? 1.05 : 1.0)
                                .animation(.spring(response: 0.3), value: addedAnimation)
                            }
                        }
                    } else {
                        Text("Bu ürün şu anda stokta bulunmamaktadır")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray5))
                            .foregroundColor(.secondary)
                            .cornerRadius(14)
                    }
                }
                .padding(20)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
    }
}
