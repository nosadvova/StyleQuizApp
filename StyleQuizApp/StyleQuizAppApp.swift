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
    @Perception.Bindable var store: StoreOf<AppFeature>

    init() {
        self.store = Store(initialState: AppFeature.State(), reducer: {
            AppFeature()
        })
        setupServices()
    }
    
    var body: some Scene {
        WindowGroup {
            WithPerceptionTracking {
                NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                    AppView(store: store)
                } destination: { store in
                        switch store.state {
                        case .userFocusScreen(_):
                            if let store = store.scope(state: \.userFocusScreen, action: \.userFocusScreen) {
                                UserFocusView(store: store)
                            }
                        case .userStyleScreen(_):
                            if let store = store.scope(state: \.userStyleScreen, action: \.userStyleScreen) {
                                UserStyleView(store: store)
                            }
                        case .userFavouriteColorScreen(_):
                            if let store = store.scope(state: \.userFavouriteColorScreen, action: \.userFavouriteColorScreen) {
                                UserFavouriteColorView(store: store)
                            }
                        }
                }
            }
        }
    }

    private func setupServices() {
        FirebaseApp.configure()

//        Task {
//            try await FirebaseService().fetchQuizPages()
//        }
    }
}
