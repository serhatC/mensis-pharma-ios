import Foundation
import SwiftUI

enum AppLanguage: String {
    case turkish = "TR"
    case english = "EN"
}

class LanguageManager: ObservableObject {
    @Published var language: AppLanguage = .turkish

    func toggle() {
        language = language == .turkish ? .english : .turkish
    }

    /// Returns the appropriate string for the current language.
    func s(_ tr: String, _ en: String) -> String {
        language == .turkish ? tr : en
    }
}
