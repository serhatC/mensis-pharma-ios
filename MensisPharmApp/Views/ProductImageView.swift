import SwiftUI

/// Displays a product image from Assets.xcassets if `imageName` is set,
/// otherwise falls back to the SF Symbol icon.
struct ProductImageView: View {
    let product: Product
    var size: CGFloat = 60
    var cornerRadius: CGFloat = 12

    var body: some View {
        Group {
            if let name = product.imageName, UIImage(named: name) != nil {
                Image(name)
                    .resizable()
                    .scaledToFit()
                    .padding(6)
            } else {
                Image(systemName: product.imageSystemName)
                    .font(.system(size: size * 0.42))
                    .foregroundColor(.brandPrimary)
            }
        }
        .frame(width: size, height: size)
        .background(Color.brandPrimary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

/// Large version used on the detail screen header
struct ProductImageViewLarge: View {
    let product: Product

    var body: some View {
        Group {
            if let name = product.imageName, UIImage(named: name) != nil {
                Image(name)
                    .resizable()
                    .scaledToFit()
                    .padding(20)
            } else {
                Image(systemName: product.imageSystemName)
                    .font(.system(size: 64))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 4)
            }
        }
    }
}
