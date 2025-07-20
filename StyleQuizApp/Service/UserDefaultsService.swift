//
//  UserDefaultsService.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 20.07.2025.
//

import Foundation
import ComposableArchitecture

struct UserDefaultsService {
    var saveStringArray: (_ key: String, _ array: [String]) -> Void
    var loadStringArray: (_ key: String) -> [String]?
    var removeValue: (_ key: String) -> Void
    var removeAll: () -> Void
    var toggleStringInArray: (_ key: String, _ value: [String]) -> Void
}

extension UserDefaultsService {
    static let live = UserDefaultsService(
        saveStringArray: { key, array in
            UserDefaults.standard.set(array, forKey: key)
        },
        loadStringArray: { key in
            UserDefaults.standard.stringArray(forKey: key)
        },
        removeValue: { key in
            UserDefaults.standard.removeObject(forKey: key)
        },
        removeAll: {
            UserDefaults.standard.removeObject(forKey: "savedAnswers")
        },
        toggleStringInArray: { key, value in
            var current = UserDefaults.standard.stringArray(forKey: key) ?? []
            if current.contains(value) {
                return
            } else {
                current.append(contentsOf: value)
            }
            UserDefaults.standard.set(current, forKey: key)
        }
    )
}

private enum UserDefaultsServiceKey: DependencyKey {
    static let liveValue = UserDefaultsService.live
}

extension DependencyValues {
    var userDefaultsService: UserDefaultsService {
        get { self[UserDefaultsServiceKey.self] }
        set { self[UserDefaultsServiceKey.self] = newValue }
    }
}
