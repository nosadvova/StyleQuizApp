//
//  LocalizationManager.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation

class LocalizationManager {
    static func localizedString(key: LocKey) -> String {
        return NSLocalizedString(key.rawValue, comment: "")
    }

    func localized(_ key: LocKey) -> String {
        return LocalizationManager.localizedString(key: key)
    }
}
