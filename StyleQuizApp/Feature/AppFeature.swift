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
        var quizPages: [QuizPage] = []
        var pagesLoading = false
    }

    enum Action: Equatable {
        case path(StackActionOf<Path>)
        case quizResponse(QuizPage)
        case startQuizTapped(QuizType)
        case pop
        case popToRoot
    }

    @Dependency(\.firebaseService) var firebaseService

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startQuizTapped(let type):
                state.pagesLoading = true
                return .run { send in
                    let quizPages = try await firebaseService.fetchQuizPages()
                    guard let focusPage = quizPages.first(where: { $0.type == type })
                    else { return }

                    await send(.quizResponse(focusPage))
                }

            case .pop:
                _ = state.path.popLast()
                return .none

            case .popToRoot:
                state.path.removeAll()
                return .none

            case .quizResponse(let quizPage):
                state.pagesLoading = false
                state.path.append(.userFocusScreen(UserFocusFeature.State(page: quizPage, selectedOptionIDs: [])))
                return .none

            case .path(.element(id: _, action: .userFocusScreen(.delegate(.pop)))):
                return .send(.pop)

            case .path(.element(id: _, action: .userFocusScreen(.delegate(.pushNext)))):
                return .none

            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }

    @Reducer
    struct Path {

        @ObservableState
        enum State: Equatable {
            case userFocusScreen(UserFocusFeature.State)
            case userStyleScreen(UserStyleFeature.State)
            case userFavouriteColorScreen(UserFavouriteColorFeature.State)
        }

        enum Action: Equatable {
            case userFocusScreen(UserFocusFeature.Action)
            case userStyleScreen(UserStyleFeature.Action)
            case userFavouriteColorScreen(UserFavouriteColorFeature.Action)
        }

        var body: some ReducerOf<Self> {
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
