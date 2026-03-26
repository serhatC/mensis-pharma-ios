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

    // MARK: - Product Data
    // Update this list with your actual products from mensispharma.com
    private func loadProducts() {

        let vitamin = Category(
            id: "vitamin",
            name: "Vitamin & Mineraller",
            icon: "🌟",
            colorHex: "F5A623",
            products: [
                Product(id: "v1", name: "C Vitamini 1000mg",
                        description: "Güçlü antioksidan ve bağışıklık desteği",
                        details: "Yüksek doz C vitamini, günlük bağışıklık sistemi desteği ve antioksidan koruma sağlar. Her kapsülde 1000mg askorbik asit bulunur. Günde 1 kapsül önerilir.",
                        unit: "Kutu (60 Tablet)", categoryId: "vitamin", isAvailable: true, imageSystemName: "pill.fill"),
                Product(id: "v2", name: "D3 Vitamini 5000 IU",
                        description: "Kemik sağlığı ve bağışıklık sistemi için",
                        details: "D3 vitamini (kolekalsiferol) kemik yoğunluğunu destekler, bağışıklık sistemini güçlendirir. 5000 IU güçlü formül. Günde 1 kapsül, yemekle alınız.",
                        unit: "Kutu (60 Kapsül)", categoryId: "vitamin", isAvailable: true, imageSystemName: "pill.fill"),
                Product(id: "v3", name: "B Kompleks Vitamini",
                        description: "Tüm B vitaminleri tek formülde",
                        details: "B1, B2, B3, B5, B6, B7, B9 ve B12 vitaminlerini içeren kapsamlı formül. Enerji metabolizması ve sinir sistemi sağlığını destekler.",
                        unit: "Kutu (60 Kapsül)", categoryId: "vitamin", isAvailable: true, imageSystemName: "capsule.fill"),
                Product(id: "v4", name: "Çinko & Selenyum",
                        description: "Bağışıklık ve antioksidan mineral kompleksi",
                        details: "Çinko ve selenyumun sinerjistik kombinasyonu bağışıklık sistemini güçlendirir, antioksidan savunmayı artırır ve üreme sağlığını destekler.",
                        unit: "Kutu (60 Tablet)", categoryId: "vitamin", isAvailable: true, imageSystemName: "pill.fill"),
                Product(id: "v5", name: "Magnezyum Bisglisinat 400mg",
                        description: "Yüksek emilimli magnezyum formu",
                        details: "Bisglisinat formu mide dostu ve yüksek emilimlidir. Kas-sinir fonksiyonu, uyku kalitesi ve stresin azaltılmasına yardımcı olur.",
                        unit: "Kutu (60 Kapsül)", categoryId: "vitamin", isAvailable: true, imageSystemName: "capsule.fill"),
                Product(id: "v6", name: "Demir + C Vitamini",
                        description: "Kan yapımı ve enerji için demir takviyesi",
                        details: "C vitaminiyle birleştirilmiş demir takviyesi. Kansızlık önleme ve enerji seviyelerini artırmaya yardımcı olur. Özellikle kadınlar için önerilir.",
                        unit: "Kutu (30 Kapsül)", categoryId: "vitamin", isAvailable: true, imageSystemName: "capsule.fill"),
            ]
        )

        let omega = Category(
            id: "omega",
            name: "Omega & Yağ Asitleri",
            icon: "🐟",
            colorHex: "1B6CA8",
            products: [
                Product(id: "o1", name: "Omega-3 Balık Yağı 1000mg",
                        description: "Kalp ve beyin sağlığı için saf balık yağı",
                        details: "EPA ve DHA açısından zengin saf balık yağı. Kalp-damar sağlığını, beyin fonksiyonlarını ve eklem sağlığını destekler. Her kapsülde 300mg EPA + 200mg DHA.",
                        unit: "Kutu (90 Kapsül)", categoryId: "omega", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "o2", name: "Omega-3-6-9 Kompleks",
                        description: "Üç esansiyel yağ asidinin dengeli kombinasyonu",
                        details: "Balık yağı, çuha çiçeği yağı ve keten tohumu yağından elde edilen omega-3, 6 ve 9'un dengeli kombinasyonu. Hormonal denge ve cilt sağlığını destekler.",
                        unit: "Kutu (60 Kapsül)", categoryId: "omega", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "o3", name: "Krill Yağı 500mg",
                        description: "Yüksek biyoyararlanımlı omega-3 kaynağı",
                        details: "Antartika krill'inden elde edilen yağ, fosfolipid formunda omega-3 içerir ve standart balık yağından daha iyi emilir. Astaksantin antioksidanı içerir.",
                        unit: "Kutu (60 Kapsül)", categoryId: "omega", isAvailable: true, imageSystemName: "drop.fill"),
            ]
        )

        let immune = Category(
            id: "immune",
            name: "Bağışıklık Sistemi",
            icon: "🛡️",
            colorHex: "27AE60",
            products: [
                Product(id: "i1", name: "Ekinezya & Çinko",
                        description: "Doğal bağışıklık güçlendirici formül",
                        details: "Ekinezya ekstresinin çinko ile güçlendirilmiş kombinasyonu. Özellikle kış aylarında bağışıklık sistemini destekler ve soğuk algınlığına karşı korur.",
                        unit: "Kutu (60 Kapsül)", categoryId: "immune", isAvailable: true, imageSystemName: "shield.fill"),
                Product(id: "i2", name: "Kuersetin 500mg",
                        description: "Güçlü bioflavonoid antioksidan",
                        details: "Soğan ve elma kabuğundan elde edilen kuersetin, güçlü antiinflamatuar ve antioksidan etki gösterir. Solunum yolu sağlığını destekler.",
                        unit: "Kutu (60 Kapsül)", categoryId: "immune", isAvailable: true, imageSystemName: "shield.fill"),
                Product(id: "i3", name: "Probiyotik Kompleks 20 Milyar",
                        description: "Çok türlü canlı probiyotik kültür",
                        details: "20 milyar CFU ve 10 farklı Lactobacillus/Bifidobacterium türü içerir. Bağırsak florasını dengeler ve bağışıklık sistemini güçlendirir.",
                        unit: "Kutu (30 Kapsül)", categoryId: "immune", isAvailable: true, imageSystemName: "cross.case.fill"),
                Product(id: "i4", name: "Spirulina 500mg",
                        description: "Protein zengini süper besin algi",
                        details: "Organik spirulina algisi, protein, B vitaminleri, demir ve antioksidanlar açısından son derece zengindir. Enerji ve bağışıklık için idealdir.",
                        unit: "Kutu (120 Tablet)", categoryId: "immune", isAvailable: true, imageSystemName: "leaf.fill"),
                Product(id: "i5", name: "Propolis Ekstresi",
                        description: "Arı propolisi ekstresinden doğal antiviral",
                        details: "Standardize propolis ekstresi güçlü antimikrobiyal ve antioksidan özellikler taşır. Boğaz ve solunum yolu sağlığına katkıda bulunur.",
                        unit: "Kutu (60 Kapsül)", categoryId: "immune", isAvailable: true, imageSystemName: "shield.fill"),
            ]
        )

        let joint = Category(
            id: "joint",
            name: "Eklem & Kemik Sağlığı",
            icon: "🦴",
            colorHex: "8E44AD",
            products: [
                Product(id: "j1", name: "Glukozamin & Kondroitin",
                        description: "Eklem kıkırdağı için temel takviye",
                        details: "Glukozamin sülfat ve kondroitin sülfat kombinasyonu. Eklem kıkırdağının yenilenmesini destekler, ağrı ve tutukluğu azaltır. Aktif bireyler için idealdir.",
                        unit: "Kutu (60 Tablet)", categoryId: "joint", isAvailable: true, imageSystemName: "figure.walk"),
                Product(id: "j2", name: "Kolajen Tip 1-2-3 Kompleks",
                        description: "Deri, eklem ve kemik için kolajen",
                        details: "Hidrolize kolajen (Tip 1, 2 ve 3) deri elastikiyetini artırır, eklem sağlığını destekler ve kemik yoğunluğuna katkıda bulunur. C vitamini ile formüle edilmiştir.",
                        unit: "Kutu (60 Kapsül)", categoryId: "joint", isAvailable: true, imageSystemName: "figure.stand"),
                Product(id: "j3", name: "Kalsiyum & D3 Vitamini",
                        description: "Kemik sağlığının temel ikilisi",
                        details: "Kalsiyum karbonattan elde edilen 1000mg kalsiyum ve D3 vitamini kombinasyonu. Kemik yoğunluğunun korunmasına ve osteoporoz önlenmesine yardımcı olur.",
                        unit: "Kutu (60 Tablet)", categoryId: "joint", isAvailable: true, imageSystemName: "pill.fill"),
                Product(id: "j4", name: "MSM 1000mg",
                        description: "Organik kükürt ile eklem ve kas sağlığı",
                        details: "Metilsülfonilmetan (MSM) eklem iltihabını azaltır, kas ağrısını giderir ve bağ dokusu sağlığını destekler. Sporculara önerilir.",
                        unit: "Kutu (90 Tablet)", categoryId: "joint", isAvailable: true, imageSystemName: "pill.fill"),
            ]
        )

        let digestion = Category(
            id: "digestion",
            name: "Sindirim & Detoks",
            icon: "🌿",
            colorHex: "16A085",
            products: [
                Product(id: "d1", name: "Probiyotik & Prebiyotik",
                        description: "Sindirim sağlığı için simbiyotik formül",
                        details: "Canlı probiyotik bakteriler ve besleyici prebiyotik lifler içeren formül. IBS, şişkinlik ve düzensiz bağırsak hareketlerine yardımcı olur.",
                        unit: "Kutu (30 Saşe)", categoryId: "digestion", isAvailable: true, imageSystemName: "cross.case.fill"),
                Product(id: "d2", name: "Sindirim Enzimi Kompleksi",
                        description: "Yiyeceklerin tam sindirimini destekler",
                        details: "Protease, lipaz, amilaz ve laktaz gibi 10 sindirim enzimi içerir. Besin emilimini artırır, şişkinlik ve gaz sorunlarını giderir.",
                        unit: "Kutu (60 Kapsül)", categoryId: "digestion", isAvailable: true, imageSystemName: "plus.circle.fill"),
                Product(id: "d3", name: "Psyllium Husk Tozu",
                        description: "Doğal lif kaynağı ve bağırsak düzenleyici",
                        details: "Yüksek lif içeriğiyle bağırsak hareketlerini düzenler, kolesterol seviyelerini destekler ve tokluk hissi sağlar. Su veya meyve suyuyla karıştırarak alınır.",
                        unit: "Şişe (300g Toz)", categoryId: "digestion", isAvailable: true, imageSystemName: "leaf.fill"),
                Product(id: "d4", name: "Zeytin Yaprağı Ekstresi",
                        description: "Antioksidan ve antibakteriyal bitki ekstresi",
                        details: "Oleuropein açısından zengin zeytin yaprağı ekstresi. Bağırsak sağlığını korur, antimikrobiyal etki gösterir ve detoks süreçlerini destekler.",
                        unit: "Kutu (60 Kapsül)", categoryId: "digestion", isAvailable: true, imageSystemName: "leaf.fill"),
                Product(id: "d5", name: "Zerdeçal & Karabiber (Curcumin)",
                        description: "Güçlü antiinflamatuar bitkisel formül",
                        details: "Standardize zerdeçal ekstresi (%95 kurkumin) ve karabiberin (piperin) kombinasyonu. Biyoyararlanımı artırılmış formül sindirim ve eklem sağlığını destekler.",
                        unit: "Kutu (60 Kapsül)", categoryId: "digestion", isAvailable: true, imageSystemName: "flame.fill"),
            ]
        )

        let energy = Category(
            id: "energy",
            name: "Enerji & Performans",
            icon: "⚡",
            colorHex: "E74C3C",
            products: [
                Product(id: "e1", name: "Koenzim Q10 100mg",
                        description: "Hücresel enerji üretimi için CoQ10",
                        details: "Ubiquinol formunda CoQ10, mitokondriyal enerji üretimini destekler. Kalp sağlığına faydalıdır, statin kullanan bireylere önerilir.",
                        unit: "Kutu (60 Kapsül)", categoryId: "energy", isAvailable: true, imageSystemName: "bolt.fill"),
                Product(id: "e2", name: "Panax Ginseng Ekstresi",
                        description: "Adaptogen bitki ile enerji ve konsantrasyon",
                        details: "Standardize Panax ginseng (%8 ginsenosit) zihinsel ve fiziksel performansı artırır, yorgunluğu azaltır ve strese adaptasyonu kolaylaştırır.",
                        unit: "Kutu (60 Kapsül)", categoryId: "energy", isAvailable: true, imageSystemName: "bolt.fill"),
                Product(id: "e3", name: "L-Karnitin 1000mg",
                        description: "Yağ yakımı ve enerji metabolizması",
                        details: "L-Tartarat formunda L-karnitin yağ asitlerinin mitokondriyal taşınmasını sağlar. Enerji üretimini destekler ve sporcularda performansı artırır.",
                        unit: "Kutu (60 Kapsül)", categoryId: "energy", isAvailable: true, imageSystemName: "flame.fill"),
                Product(id: "e4", name: "Ashwagandha KSM-66",
                        description: "Stres adaptojeni ve enerji desteği",
                        details: "Klinik araştırmalarda desteklenmiş KSM-66 ashwagandha ekstresi. Kortizol seviyelerini dengeleyerek stresle başa çıkmayı kolaylaştırır, enerji verir.",
                        unit: "Kutu (60 Kapsül)", categoryId: "energy", isAvailable: true, imageSystemName: "sparkles"),
            ]
        )

        let womens = Category(
            id: "womens",
            name: "Kadın Sağlığı",
            icon: "🌸",
            colorHex: "E91E8C",
            products: [
                Product(id: "w1", name: "Folik Asit 400mcg",
                        description: "Gebelik öncesi ve hamilelikte temel vitamin",
                        details: "Nöral tüp defektlerinin önlenmesinde kritik rol oynayan folik asit. Gebelik planlayan ve hamile kadınlara günde 1 tablet önerilir.",
                        unit: "Kutu (90 Tablet)", categoryId: "womens", isAvailable: true, imageSystemName: "heart.fill"),
                Product(id: "w2", name: "Gebelik Multivitamini",
                        description: "Hamile ve emziren kadınlar için kapsamlı formül",
                        details: "Folik asit, demir, iyot, D3, B12 ve diğer gebelikte kritik vitaminleri içeren tam formül. Hem anne hem bebek sağlığını destekler.",
                        unit: "Kutu (60 Kapsül)", categoryId: "womens", isAvailable: true, imageSystemName: "heart.fill"),
                Product(id: "w3", name: "Çuha Çiçeği Yağı (Evening Primrose)",
                        description: "Hormonal denge ve PMS desteği",
                        details: "GLA (gama linolenik asit) açısından zengin çuha çiçeği yağı. PMS semptomlarını hafifletir, hormonal dengeyi destekler ve cilt sağlığına katkıda bulunur.",
                        unit: "Kutu (90 Kapsül)", categoryId: "womens", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "w4", name: "Menopoz Destek Formülü",
                        description: "Soya izoflavorları ile menopoz semptom desteği",
                        details: "Soya izoflavonları, B6, D3 ve kalsiyum içeren özel menopoz formülü. Sıcak basması, mood değişimleri ve kemik sağlığını destekler.",
                        unit: "Kutu (60 Tablet)", categoryId: "womens", isAvailable: true, imageSystemName: "heart.fill"),
            ]
        )

        let skinHair = Category(
            id: "skinhair",
            name: "Cilt & Saç Sağlığı",
            icon: "✨",
            colorHex: "9B59B6",
            products: [
                Product(id: "s1", name: "Biotin 5000mcg",
                        description: "Saç ve tırnak sağlığı için yüksek doz biotin",
                        details: "Yüksek doz biotin (B7 vitamini) saç dökülmesini azaltır, tırnak sağlamlaşmasına yardımcı olur ve cilt kalitesini iyileştirir.",
                        unit: "Kutu (90 Kapsül)", categoryId: "skinhair", isAvailable: true, imageSystemName: "sparkles"),
                Product(id: "s2", name: "Hidrolize Kolajen Peptid",
                        description: "Cilt elastikiyeti ve gençlik formülü",
                        details: "Marine ve bovin kaynaktan hidrolize kolajen peptidler cilt elastikiyetini artırır, kırışıklıkları azaltır ve eklem sağlığını destekler.",
                        unit: "Kutu (60 Kapsül)", categoryId: "skinhair", isAvailable: true, imageSystemName: "sparkles"),
                Product(id: "s3", name: "Hyalüronik Asit 200mg",
                        description: "Cilt nemlendiricisi ve eklem koruyucu",
                        details: "Düşük moleküler ağırlıklı hyalüronik asit cilt nem dengesini korur, ince çizgileri azaltır ve eklem sıvısı sağlığını destekler.",
                        unit: "Kutu (60 Kapsül)", categoryId: "skinhair", isAvailable: true, imageSystemName: "drop.fill"),
                Product(id: "s4", name: "E Vitamini 400 IU",
                        description: "Güçlü antioksidan cilt vitamini",
                        details: "Doğal kaynaklı d-alfa tokoferol. Serbest radikal hasarından korur, cilt iyileşmesini hızlandırır ve UV hasarına karşı cilt savunmasını güçlendirir.",
                        unit: "Kutu (60 Softgel)", categoryId: "skinhair", isAvailable: true, imageSystemName: "sun.max.fill"),
            ]
        )

        categories = [vitamin, omega, immune, joint, digestion, energy, womens, skinHair]
    }
}
