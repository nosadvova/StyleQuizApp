//
//  StyleQuizAppApp.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import ComposableArchitecture

@main
struct StyleQuizAppApp: App {
    init() {
        setupServices()
    }

    var body: some Scene {
        WindowGroup {
            WelcomeView(store: Store(initialState: WelcomeFeature.State(), reducer: {
                WelcomeFeature()
            }))
        }
    }

    private func setupServices() {
        FirebaseApp.configure()

//        Task {
//            try await FirebaseService().fetchQuizPages()
//        }
    }
}
