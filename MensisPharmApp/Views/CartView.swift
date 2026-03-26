import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartViewModel
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
            .navigationTitle("Sepetim")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if !cart.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Temizle") {
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

    // MARK: - Empty State

    private var emptyCartView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart.badge.questionmark")
                .font(.system(size: 64))
                .foregroundColor(.secondary.opacity(0.5))
            Text("Sepetiniz Boş")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Text("Ürünlere göz atarak sipariş oluşturabilirsiniz.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }

    // MARK: - Cart List

    private var cartListView: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    ForEach(cart.items) { item in
                        CartItemRow(item: item)
                    }
                    .onDelete { indexSet in
                        for i in indexSet {
                            cart.remove(cart.items[i].product)
                        }
                    }
                } header: {
                    Text("Ürünler (\(cart.items.count) çeşit)")
                }

                Section {
                    HStack {
                        Text("Toplam Adet")
                        Spacer()
                        Text("\(cart.totalItemCount) adet")
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.orange)
                        Text("Fiyatlandırma siparişiniz alındıktan sonra tarafınıza iletilecektir.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Özet")
                }
            }
            .listStyle(.insetGrouped)

            // Checkout Button
            Button(action: { showCheckout = true }) {
                HStack {
                    Image(systemName: "envelope.fill")
                    Text("Sipariş Ver")
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
            Image(systemName: item.product.imageSystemName)
                .font(.system(size: 20))
                .foregroundColor(.brandPrimary)
                .frame(width: 40, height: 40)
                .background(Color.brandPrimary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

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
