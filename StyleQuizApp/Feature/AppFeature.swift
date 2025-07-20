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
        var welcomeScreen = WelcomeFeature.State()
        var quizPages: [QuizPage] = []
    }

    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case welcomeScreen(WelcomeFeature.Action)
//        case storeQuizPages([QuizPage])

        case popToRoot
    }

    @Dependency(\.firebaseService) var firebaseService

    var body: some ReducerOf<Self> {
        Scope(state: \.welcomeScreen, action: \.welcomeScreen) {
            WelcomeFeature()
        }

        Reduce { state, action in
            switch action {

            case .popToRoot:
                state.path.removeAll()
                return .none

            case .welcomeScreen(.delegate(.pushNext(let quizPage))):
                state.path.append(.userFocusScreen(UserFocusFeature.State(quizPage: quizPage)))
                return .none

            case .welcomeScreen(.delegate(.storeQuizPages(let pages))):
                state.quizPages = pages
                return .none

            case .welcomeScreen(.showQuizHistoryTapped):
                state.path.append(.savedAnswersScreen(SavedAnswersFeature.State(quizPages: state.quizPages)))
                return .none

            case .path(.element(id: _, action: .userFocusScreen(.delegate(.pushNext(let index))))):
                guard let quizPage = state.quizPages.first(where: { $0.order == index }) else {
                    return .none
                }

                state.path.append(.userStyleScreen(UserStyleFeature.State(quizPage: quizPage)))
                return .none

            case .path(.element(id: _, action: .userStyleScreen(.delegate(.pushNext(let index))))):
                guard let quizPage = state.quizPages.first(where: { $0.order == index }) else {
                    return .none
                }

                state.path.append(.userFavouriteColorScreen(UserFavouriteColorFeature.State(quizPage: quizPage)))
                return .none

            case .path(.element(id: _, action: .userFavouriteColorScreen(.delegate(.popToRoot)))):
                return .send(.popToRoot)

            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

    @Reducer(state: .equatable)
    enum Path {
        case savedAnswersScreen(SavedAnswersFeature)
        case userFocusScreen(UserFocusFeature)
        case userStyleScreen(UserStyleFeature)
        case userFavouriteColorScreen(UserFavouriteColorFeature)
    }
}
