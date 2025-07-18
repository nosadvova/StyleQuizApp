//
//  AppFeature.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {

    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
    }

    enum Action {
        case path(StackActionOf<Path>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }

    @Reducer
    struct Path {
//        case welcomeScreen(WelcomeFeature.State)
//        case userFocusScreen(UserFocusFeature.State)
//        case userStyleScreen(UserStyleFeature.State)
//        case userFavouriteColorScreen(UserFavouriteColorFeature.State)

        enum State: Equatable {
            case welcomeScreen(WelcomeFeature.State)
            case userFocusScreen(UserFocusFeature.State)
            case userStyleScreen(UserStyleFeature.State)
            case userFavouriteColorScreen(UserFavouriteColorFeature.State)
        }

        enum Action: Equatable {
            case welcomeScreen(WelcomeFeature.Action)
            case userFocusScreen(UserFocusFeature.Action)
            case userStyleScreen(UserStyleFeature.Action)
            case userFavouriteColorScreen(UserFavouriteColorFeature.Action)
        }

        var body: some ReducerOf<Self> {
            Scope(state: \.welcomeScreen, action: \.welcomeScreen) {
                WelcomeFeature()
            }
            Scope(state: \.userFocusScreen, action: \.userFocusScreen) {
                UserFocusFeature()
            }
            Scope(state: \.userStyleScreen, action: \.userStyleScreen) {
                UserStyleFeature()
            }
            Scope(state: \.userFavouriteColorScreen, action: \.userFavouriteColorScreen) {
                UserFavouriteColorFeature()
            }
        }
    }
}
