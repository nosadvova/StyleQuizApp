//
//  StyleQuizAppApp.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import SwiftUI
import Firebase

@main
struct StyleQuizAppApp: App {
    init() {
        setupServices()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func setupServices() {
        FirebaseApp.configure()
    }
}
