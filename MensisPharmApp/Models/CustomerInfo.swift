import Foundation

struct CustomerInfo {
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    var address: String = ""
    var city: String = ""
    var district: String = ""
    var notes: String = ""

    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty &&
        !address.trimmingCharacters(in: .whitespaces).isEmpty &&
        !city.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
