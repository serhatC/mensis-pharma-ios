import Foundation
import SwiftUI

class ProductStore: ObservableObject {
    @Published var categories: [Category] = []
    @Published var searchText: String = ""

    var filteredCategories: [Category] {
        if searchText.isEmpty { return categories }
        return categories.compactMap { cat in
            let filtered = cat.products.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
            return filtered.isEmpty ? nil : Category(
                id: cat.id, name: cat.name, icon: cat.icon,
                colorHex: cat.colorHex, products: filtered
            )
        }
    }

    init() {
        loadProducts()
    }

    private func loadProducts() {

        // MARK: - Krill Yağı
        let krillOil = Category(
            id: "krill",
            name: "Krill Yağı",
            icon: "🐟",
            colorHex: "1B6CA8",
            products: [
                Product(id: "k1",
                        name: "NutraMedica Krill Complex",
                        description: "Omega-3, fosfolipid ve astaksantin kompleksi",
                        details: "Fosfolipid formunda omega-3, astaksantin antioksidanı ve kolin içeren kapsamlı krill kompleksi. Kalp, beyin ve eklem sağlığını destekler.",
                        unit: "30 Kapsül",
                        categoryId: "krill", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "k2",
                        name: "Nutramedica Krill Oil 750 mg",
                        description: "Saf krill yağı — yüksek emilimli omega-3",
                        details: "Her kapsülde 750mg saf Antarktika krill yağı içerir. Fosfolipid yapısı sayesinde balık yağından daha iyi emilir. Antiinflamatuar ve kalp dostu formül.",
                        unit: "30 Kapsül",
                        categoryId: "krill", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "k3",
                        name: "Nutramedica Krill Oil 750 mg",
                        description: "Saf krill yağı — ekonomik büyük paket",
                        details: "Her kapsülde 750mg saf Antarktika krill yağı içerir. Fosfolipid yapısı sayesinde balık yağından daha iyi emilir. Antiinflamatuar ve kalp dostu formül.",
                        unit: "60 Kapsül",
                        categoryId: "krill", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "k4",
                        name: "Nutramedica Krill Kidz Liquid",
                        description: "Çocuklar için sıvı krill yağı",
                        details: "Çocuklar için özel formüle edilmiş sıvı krill yağı. Beyin gelişimini, konsantrasyonu ve bağışıklık sistemini destekler. Kolay kullanım için sıvı formda.",
                        unit: "150 ml / 5 fl oz",
                        categoryId: "krill", isAvailable: true, imageSystemName: "drop.fill"),
            ]
        )

        // MARK: - Vitaminler
        let vitamins = Category(
            id: "vitamins",
            name: "Vitaminler",
            icon: "💊",
            colorHex: "F5A623",
            products: [
                Product(id: "v1",
                        name: "NutraMedica MultiMix B",
                        description: "Tüm B grubu vitaminleri tek formülde",
                        details: "B1, B2, B3, B5, B6, B7, B9 ve B12 vitaminlerini içeren kapsamlı B kompleks formülü. Enerji metabolizması, sinir sistemi ve hücre sağlığını destekler.",
                        unit: "30 Kapsül",
                        categoryId: "vitamins", isAvailable: true, imageSystemName: "pill.fill"),
                Product(id: "v2",
                        name: "NutraMedica MultiMix B",
                        description: "Tüm B grubu vitaminleri — ekonomik paket",
                        details: "B1, B2, B3, B5, B6, B7, B9 ve B12 vitaminlerini içeren kapsamlı B kompleks formülü. Enerji metabolizması, sinir sistemi ve hücre sağlığını destekler.",
                        unit: "60 Kapsül",
                        categoryId: "vitamins", isAvailable: true, imageSystemName: "pill.fill"),
                Product(id: "v3",
                        name: "NutraMedica MgComplex + D3&K2",
                        description: "Magnezyum, D3 ve K2 vitamini kombinasyonu",
                        details: "Yüksek emilimli magnezyum bisglisinat ile D3 ve K2 vitaminlerinin sinerjistik kombinasyonu. Kemik sağlığı, kas fonksiyonu ve kardiyovasküler sistemi destekler.",
                        unit: "60 Kapsül",
                        categoryId: "vitamins", isAvailable: true, imageSystemName: "capsule.fill"),
                Product(id: "v4",
                        name: "NutraVieX C VIT1000 Extra",
                        description: "1000mg C vitamini — tablet form",
                        details: "Güçlü antioksidan koruması için 1000mg C vitamini içerir. Bağışıklık sistemini güçlendirir, demir emilimini artırır ve hücre yenilenmesini destekler.",
                        unit: "Tablet",
                        categoryId: "vitamins", isAvailable: true, imageSystemName: "pill.fill"),
                Product(id: "v5",
                        name: "NutraVieX C VIT1000 Extra",
                        description: "1000mg C vitamini — efervesan form",
                        details: "Suda çözünen efervesan formatta 1000mg C vitamini. Hızlı emilim sağlar. Bağışıklık sistemini destekler ve enerji seviyelerini artırır. Lezzetli portakal aromalı.",
                        unit: "Efervesan Tablet",
                        categoryId: "vitamins", isAvailable: true, imageSystemName: "bubbles.and.sparkles.fill"),
                Product(id: "v6",
                        name: "Nutramedica D3 All Spray",
                        description: "Pratik D3 vitamini oral sprey",
                        details: "Yetişkinler için 1000 IU D3 vitamini içeren oral sprey. Dil altına uygulanarak hızlı emilim sağlar. Kemik sağlığı, bağışıklık ve ruh hali için önerilir.",
                        unit: "1000 IU Sprey",
                        categoryId: "vitamins", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "v7",
                        name: "Nutramedica D3 Kidz Spray",
                        description: "Çocuklar için D3 vitamini oral sprey",
                        details: "Bebekler ve çocuklar için 400 IU D3 vitamini içeren oral sprey. Kemik ve diş gelişimini, bağışıklık sistemini destekler. Alkol içermez, çocuklar için güvenli formül.",
                        unit: "400 IU Çocuk Spreyi",
                        categoryId: "vitamins", isAvailable: true, imageSystemName: "drop.fill"),
            ]
        )

        // MARK: - Bağışıklık Sistemi
        let immune = Category(
            id: "immune",
            name: "Bağışıklık Sistemi",
            icon: "🛡️",
            colorHex: "27AE60",
            products: [
                Product(id: "i1",
                        name: "NutraVieX Sambucus Complex",
                        description: "Mürver kompleksi — efervesan form",
                        details: "Sambucus nigra (mürver) ekstresi, C vitamini ve çinko içeren efervesan formül. Bağışıklık sistemini güçlendirir, soğuk algınlığı ve grip semptomlarına karşı etkilidir.",
                        unit: "Efervesan Tablet",
                        categoryId: "immune", isAvailable: true, imageSystemName: "shield.fill"),
                Product(id: "i2",
                        name: "NutraVieX Plus Umckaloabo-Sambucus",
                        description: "Pelargonyum ve mürver — efervesan form",
                        details: "Umckaloabo (Pelargonium sidoides) ve Sambucus nigra ekstrelerinin güçlü kombinasyonu. Üst solunum yolu enfeksiyonlarına karşı doğal destek. Efervesan form.",
                        unit: "Efervesan Tablet",
                        categoryId: "immune", isAvailable: true, imageSystemName: "shield.fill"),
                Product(id: "i3",
                        name: "Nutraviex Kidz Umckaloabo-Sambucus",
                        description: "Çocuklar için bağışıklık şurubu",
                        details: "Çocuklar için özel formüle edilmiş Umckaloabo ve Sambucus içeren şurup. Üst solunum yolu sağlığını destekler, bağışıklık sistemini güçlendirir. Lezzetli çilek aromalı.",
                        unit: "Şurup",
                        categoryId: "immune", isAvailable: true, imageSystemName: "cross.case.fill"),
                Product(id: "i4",
                        name: "NutraVieX Plus Umckaloabo-Sambucus",
                        description: "Pelargonyum ve mürver — tablet form",
                        details: "Umckaloabo (Pelargonium sidoides) ve Sambucus nigra ekstrelerinin güçlü kombinasyonu. Üst solunum yolu enfeksiyonlarına karşı doğal destek. Tablet form.",
                        unit: "Tablet",
                        categoryId: "immune", isAvailable: true, imageSystemName: "shield.fill"),
                Product(id: "i5",
                        name: "NutraVieX Plus Umckaloabo-Sambucus",
                        description: "Pelargonyum ve mürver — pastil form",
                        details: "Umckaloabo (Pelargonium sidoides) ve Sambucus nigra ekstrelerinin güçlü kombinasyonu. Üst solunum yolu sağlığını destekler. Kullanımı kolay pastil form.",
                        unit: "Pastil",
                        categoryId: "immune", isAvailable: true, imageSystemName: "shield.fill"),
            ]
        )

        // MARK: - Adli Tıp Ürünleri
        let forensic = Category(
            id: "forensic",
            name: "Adli Tıp Ürünleri",
            icon: "🔬",
            colorHex: "5D6D7E",
            products: [
                Product(id: "f1",
                        name: "De-Tox Tubes A",
                        description: "Adli toksikoloji örnek toplama tüpü — Tip A",
                        details: "Adli toksikoloji analizleri için özel formüle edilmiş örnek toplama ve saklama tüpü. Laboratuvar ve adli bilimciler için profesyonel çözüm.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "testtube.2"),
                Product(id: "f2",
                        name: "De-Tox Tubes B",
                        description: "Adli toksikoloji örnek toplama tüpü — Tip B",
                        details: "Adli toksikoloji analizleri için özel formüle edilmiş örnek toplama ve saklama tüpü. Laboratuvar ve adli bilimciler için profesyonel çözüm.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "testtube.2"),
                Product(id: "f3",
                        name: "HemaFlx",
                        description: "Kan örneği stabilizasyon çözümü",
                        details: "Kan örneklerinin toplanması, saklanması ve analizinde kullanılan stabilizasyon çözümü. Adli tıp laboratuvarları için tasarlanmıştır.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "f4",
                        name: "OraFlx",
                        description: "Oral sıvı örnek toplama sistemi",
                        details: "Tükürük/oral sıvı örneklerinin toplanması ve stabilizasyonu için geliştirilmiş sistem. Non-invazif ve kullanımı kolay format.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "cross.case.fill"),
                Product(id: "f5",
                        name: "SeraFlx LCMSMS",
                        description: "Serum matrisi LC-MS/MS analizi için",
                        details: "LC-MS/MS bazlı adli toksikoloji analizleri için optimize edilmiş serum matrisi referans çözümü. Yüksek hassasiyetli analizler için tasarlanmıştır.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "flask.fill"),
                Product(id: "f6",
                        name: "SeraFlx Biomatrix",
                        description: "Biyomatrix serum referans çözümü",
                        details: "Adli toksikoloji laboratuvarları için biyomatrix bazlı serum referans çözümü. Kalibrasyon ve kalite kontrol amaçlı kullanılır.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "flask.fill"),
                Product(id: "f7",
                        name: "Surine E Control",
                        description: "İdrar DOA analizi kontrol çözümü — Tip E",
                        details: "İdrarla ilaç analizi (DOA) testleri için kalite kontrol çözümü. Laboratuvar doğruluğunu ve tutarlılığını sağlamak amacıyla kullanılır.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "cross.vial.fill"),
                Product(id: "f8",
                        name: "Surine F Control",
                        description: "İdrar DOA analizi kontrol çözümü — Tip F",
                        details: "İdrarla ilaç analizi (DOA) testleri için kalite kontrol çözümü. Laboratuvar doğruluğunu ve tutarlılığını sağlamak amacıyla kullanılır.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "cross.vial.fill"),
                Product(id: "f9",
                        name: "Surine In-House DOA",
                        description: "Kurum içi DOA test kontrol çözümü",
                        details: "Kurum içi ilaç tarama programları için özel olarak geliştirilmiş kontrol çözümü. Güvenilir ve tekrarlanabilir sonuçlar için optimize edilmiştir.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "cross.vial.fill"),
                Product(id: "f10",
                        name: "Surine Negative Control",
                        description: "DOA negatif kontrol çözümü",
                        details: "İlaç analizi testlerinde negatif referans olarak kullanılan kontrol çözümü. Test sisteminin doğru kalibrasyonu için kritik öneme sahiptir.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "cross.vial.fill"),
                Product(id: "f11",
                        name: "Surine Preservative Free Control",
                        description: "Koruyucu içermeyen DOA kontrol çözümü",
                        details: "Koruyucu madde içermeyen özel formülasyon. Koruyucu madde girişiminin söz konusu olduğu hassas DOA analizleri için idealdir.",
                        unit: "Paket",
                        categoryId: "forensic", isAvailable: true, imageSystemName: "cross.vial.fill"),
            ]
        )

        // MARK: - İhracat Ürünleri
        let export = Category(
            id: "export",
            name: "İhracat Ürünleri",
            icon: "🌍",
            colorHex: "1A5276",
            products: [
                Product(id: "e1",
                        name: "İhracat Ürünleri",
                        description: "Uluslararası ihracat ürünleri için bizimle iletişime geçin",
                        details: "Mensis Pharma'nın ihracat ürün kataloğu hakkında detaylı bilgi almak için lütfen bizimle iletişime geçiniz. Özel fiyatlandırma ve teslimat koşulları için ticari ekibimiz size yardımcı olacaktır.",
                        unit: "İletişime Geçin",
                        categoryId: "export", isAvailable: true, imageSystemName: "shippingbox.fill"),
            ]
        )

        categories = [krillOil, vitamins, immune, forensic, export]
    }
}
