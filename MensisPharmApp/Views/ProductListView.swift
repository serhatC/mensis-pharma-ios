import SwiftUI

struct ProductListView: View {
    let category: Category
    @EnvironmentObject var cart: CartViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(category.products) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductCardView(product: product)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ProductCardView: View {
    let product: Product
    @EnvironmentObject var cart: CartViewModel

    var body: some View {
        HStack(spacing: 14) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.brandPrimary.opacity(0.1))
                    .frame(width: 60, height: 60)
                Image(systemName: product.imageSystemName)
                    .font(.system(size: 26))
                    .foregroundColor(.brandPrimary)
            }

            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                Text(product.unit)
                    .font(.caption)
                    .foregroundColor(.brandPrimary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.brandPrimary.opacity(0.1))
                    .cornerRadius(6)
            }

            Spacer()

            // Cart action
            VStack(spacing: 6) {
                if cart.isInCart(product) {
                    HStack(spacing: 0) {
                        Button(action: { cart.decreaseQuantity(of: product) }) {
                            Image(systemName: "minus")
                                .font(.system(size: 12, weight: .bold))
                                .frame(width: 28, height: 28)
                                .background(Color(.systemGray5))
                                .clipShape(Circle())
                        }
                        Text("\(cart.quantity(of: product))")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .frame(width: 28)
                        Button(action: { cart.add(product) }) {
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.brandPrimary)
                                .clipShape(Circle())
                        }
                    }
                } else {
                    Button(action: { cart.add(product) }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.brandPrimary)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
        .opacity(product.isAvailable ? 1 : 0.5)
    }
}
