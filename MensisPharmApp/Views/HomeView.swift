import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: ProductStore
    @EnvironmentObject var cart: CartViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Hero Banner
                    heroBanner

                    // Search Bar
                    searchBar
                        .padding(.horizontal)
                        .padding(.vertical, 12)

                    if store.searchText.isEmpty {
                        // Categories Grid
                        categoriesGrid
                    } else {
                        // Search Results
                        searchResults
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Mensis Pharma")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart.fill")
                                .foregroundColor(.brandPrimary)
                                .font(.system(size: 20))
                            if cart.totalItemCount > 0 {
                                Text("\(cart.totalItemCount)")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(minWidth: 16, minHeight: 16)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Sub Views

    private var heroBanner: some View {
        ZStack {
            LinearGradient(
                colors: [Color.brandPrimary, Color.brandPrimary.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 8) {
                Image(systemName: "cross.case.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.white.opacity(0.9))
                Text("Sağlıklı Yaşam\nİçin Doğal Çözümler")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("Sipariş verin, kapınıza gelsin")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(.vertical, 28)
        }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Ürün ara...", text: $store.searchText)
                .autocorrectionDisabled()
            if !store.searchText.isEmpty {
                Button(action: { store.searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(10)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.06), radius: 4, y: 2)
    }

    private var categoriesGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
            ForEach(store.categories) { category in
                NavigationLink(destination: ProductListView(category: category)) {
                    CategoryCardView(category: category)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }

    private var searchResults: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(store.filteredCategories) { category in
                VStack(alignment: .leading, spacing: 8) {
                    Text(category.name)
                        .font(.headline)
                        .padding(.horizontal)
                    ForEach(category.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductRowView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                }
            }
            if store.filteredCategories.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                    Text("Sonuç bulunamadı")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
            }
        }
        .padding(.bottom, 20)
    }
}

struct CategoryCardView: View {
    let category: Category

    var body: some View {
        VStack(spacing: 10) {
            Text(category.icon)
                .font(.system(size: 38))
                .frame(width: 64, height: 64)
                .background(category.color.opacity(0.15))
                .clipShape(Circle())
            Text(category.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            Text("\(category.products.count) ürün")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
    }
}

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack(spacing: 12) {
            ProductImageView(product: product, size: 44, cornerRadius: 10)

            VStack(alignment: .leading, spacing: 2) {
                Text(product.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(product.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.04), radius: 3, y: 2)
    }
}
