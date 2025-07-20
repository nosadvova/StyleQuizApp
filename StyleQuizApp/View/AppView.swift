//
//  AppView.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @Perception.Bindable var store: StoreOf<AppFeature>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                WelcomeView(store: store.scope(state: \.welcomeScreen, action: \.welcomeScreen))
            } destination: { store in
                switch store.state {
                case .savedAnswersScreen(_):
                    if let store = store.scope(state: \.savedAnswersScreen, action: \.savedAnswersScreen) {
                        SavedAnswersView(store: store)
                    }
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
