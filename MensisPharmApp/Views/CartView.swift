import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartViewModel
    @EnvironmentObject var lang: LanguageManager
    @State private var showCheckout = false

    var body: some View {
        NavigationStack {
            Group {
                if cart.isEmpty {
                    emptyCartView
                } else {
                    cartListView
                }
            }
            .navigationTitle(lang.s("Sepetim", "My Cart"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if !cart.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(lang.s("Temizle", "Clear")) {
                            withAnimation { cart.clearCart() }
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationDestination(isPresented: $showCheckout) {
                CheckoutView()
            }
        }
    }

    private var emptyCartView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart.badge.questionmark")
                .font(.system(size: 64))
                .foregroundColor(.secondary.opacity(0.5))
            Text(lang.s("Sepetiniz Boş", "Your Cart is Empty"))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Text(lang.s(
                "Ürünlere göz atarak sipariş oluşturabilirsiniz.",
                "Browse products to create your order."
            ))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
        }
    }

    private var cartListView: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    ForEach(cart.items) { item in
                        CartItemRow(item: item)
                    }
                    .onDelete { indexSet in
                        for i in indexSet { cart.remove(cart.items[i].product) }
                    }
                } header: {
                    Text(lang.s("Ürünler (\(cart.items.count) çeşit)", "Products (\(cart.items.count) items)"))
                }

                Section {
                    HStack {
                        Text(lang.s("Toplam Adet", "Total Quantity"))
                        Spacer()
                        Text("\(cart.totalItemCount) \(lang.s("adet", "items"))")
                            .fontWeight(.semibold)
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "info.circle").foregroundColor(.orange)
                        Text(lang.s(
                            "Fiyatlandırma siparişiniz alındıktan sonra tarafınıza iletilecektir.",
                            "Pricing will be communicated after your order is received."
                        ))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                } header: {
                    Text(lang.s("Özet", "Summary"))
                }
            }
            .listStyle(.insetGrouped)

            Button(action: { showCheckout = true }) {
                HStack {
                    Image(systemName: "envelope.fill")
                    Text(lang.s("Sipariş Ver", "Place Order"))
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .padding()
                .background(Color.brandPrimary)
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
    }
}

struct CartItemRow: View {
    let item: CartItem
    @EnvironmentObject var cart: CartViewModel

    var body: some View {
        HStack(spacing: 12) {
            ProductImageView(product: item.product, size: 40, cornerRadius: 8)
            VStack(alignment: .leading, spacing: 2) {
                Text(item.product.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                Text(item.product.unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            HStack(spacing: 2) {
                Button(action: { cart.decreaseQuantity(of: item.product) }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
                Text("\(item.quantity)")
                    .font(.headline)
                    .frame(minWidth: 28)
                    .multilineTextAlignment(.center)
                Button(action: { cart.add(item.product) }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.brandPrimary)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 4)
    }
}
