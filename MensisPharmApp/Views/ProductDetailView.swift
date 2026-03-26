import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cart: CartViewModel
    @EnvironmentObject var lang: LanguageManager
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
                        ProductImageViewLarge(product: product)
                        if !product.isAvailable {
                            Text(lang.s("Stokta Yok", "Out of Stock"))
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
                        Text(lang.s(product.name, product.nameEN))
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
                        Text(lang.s(product.description, product.descriptionEN))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Divider()

                    // Details
                    VStack(alignment: .leading, spacing: 8) {
                        Label(lang.s("Ürün Detayları", "Product Details"), systemImage: "info.circle.fill")
                            .font(.headline)
                            .foregroundColor(.brandPrimary)
                        Text(lang.s(product.details, product.detailsEN))
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }

                    Divider()

                    // Price note
                    HStack {
                        Image(systemName: "tag.fill").foregroundColor(.orange)
                        Text(lang.s(
                            "Fiyat bilgisi için sipariş veriniz. En kısa sürede dönüş yapılacaktır.",
                            "Place an order for pricing. We will get back to you shortly."
                        ))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    .padding(14)
                    .background(Color.orange.opacity(0.08))
                    .cornerRadius(12)

                    // Cart controls
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
                                    Label(lang.s("Çıkar", "Remove"), systemImage: "trash")
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
                                    Text(addedAnimation
                                         ? lang.s("Sepete Eklendi!", "Added to Cart!")
                                         : lang.s("Sepete Ekle", "Add to Cart"))
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
                        Text(lang.s(
                            "Bu ürün şu anda stokta bulunmamaktadır",
                            "This product is currently out of stock"
                        ))
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
