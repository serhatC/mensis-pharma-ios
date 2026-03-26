# Mensis Pharma iOS App — Setup Guide

## Requirements
- Xcode 15+
- iOS 17+ deployment target
- macOS 14+ (for development)

---

## Creating the Xcode Project

1. Open Xcode
2. Select **File → New → Project**
3. Choose **iOS → App** → **Next**
4. Fill in the following settings:
   - **Product Name:** `MensisPharmApp`
   - **Team:** (your Apple Developer account)
   - **Bundle Identifier:** `com.mensispharma.app`
   - **Interface:** SwiftUI
   - **Language:** Swift
5. When choosing a save location, select `/Users/serhat/MensisPharmApp/`
   - ⚠️ Xcode will create another `MensisPharmApp` subfolder — save into the **outer** folder
6. Click **Create**

---

## Adding the Source Files to the Project

After Xcode creates the project, remove the auto-generated files and add the prepared ones:

### 1. Delete the auto-generated files
In the Xcode project navigator, select the following files, right-click → **Delete → Move to Trash**:
- `ContentView.swift`
- `MensisPharmApp.swift`

### 2. Drag the folders into the project
Open `/Users/serhat/MensisPharmApp/MensisPharmApp/` in Finder.
Drag the following files and folders into the **project navigator** (make sure **Add to target** is checked):
- `MensisPharmApp.swift`
- `ContentView.swift`
- `Models/` (entire folder)
- `ViewModels/` (entire folder)
- `Views/` (entire folder)
- `Services/` (entire folder)

### 3. Add the MessageUI Framework
1. Click the project file in the left navigator
2. Go to **Target → General → Frameworks, Libraries, and Embedded Content**
3. Click the **+** button
4. Search for `MessageUI.framework` and add it

---

## Configuration

### Update the Order Email
In `ViewModels/CartViewModel.swift`:
```swift
let orderEmail = "siparis@mensispharma.com"  // ← Replace with your real order email
```

### Update Contact Information
In `Views/AboutView.swift`:
```swift
let phone = "+90 XXX XXX XX XX"          // ← Real phone number
let email = "info@mensispharma.com"      // ← Real email
let address = "Adres bilgisi"            // ← Real address
```

### Update the Product List
In `ViewModels/ProductStore.swift`, update the `loadProducts()` function with your actual products from mensispharma.com. Each product follows this structure:
```swift
Product(
    id: "unique_id",          // unique string ID
    name: "Ürün Adı",         // product name (Turkish)
    description: "Kısa açıklama",  // short description
    details: "Uzun açıklama...",   // full detail text
    unit: "Kutu (60 Tablet)", // packaging unit
    categoryId: "vitamin",    // must match a category id
    isAvailable: true,        // stock availability
    imageSystemName: "pill.fill"  // SF Symbol icon name
)
```

---

## App Features

| Feature | Description |
|---------|-------------|
| 8 Product Categories | Vitamins, Omega, Immunity, Joints, Digestion, Energy, Women's Health, Skin & Hair |
| 36+ Products | With full Turkish descriptions |
| Cart Management | Add, remove, adjust quantities |
| Order Form | Customer name, phone, address, city, notes |
| Email Orders | Native mail compose (MFMailComposeViewController) |
| Turkish UI | Fully in Turkish |
| Product Search | Live search filter across all categories |
| About Page | Contact info and ordering guide |

---

## Build & Run

1. Select **iPhone 15** (or any device) as the simulator
2. Press **⌘R** to build and run

> ⚠️ **Note:** Email sending only works on a **real device**. On the simulator, a mailto fallback is used instead.

---

## Publishing to the App Store

1. Register the Bundle ID in your Apple Developer account
2. Set your Team in the project's Signing settings
3. Go to **Product → Archive** to create an archive
4. Upload to App Store Connect via Xcode Organizer
