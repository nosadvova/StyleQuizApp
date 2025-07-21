//
//  WelcomeFeature.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 20.07.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WelcomeFeature {

    @ObservableState
    struct State: Equatable {
        var quizPages: [QuizPage] = []
        var pagesLoading = false
        let nextPageIndex = 0
    }

    enum Action: Equatable {
        case quizResponse(QuizPage)
        case startQuizTapped(Int)
        case showQuizHistoryTapped
        case delegate(Delegate)

        enum Delegate: Equatable {
            case pushNext(QuizPage)
            case storeQuizPages([QuizPage])
        }
    }

    @Dependency(\.firebaseService) var firebaseService

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startQuizTapped(let index):
                state.pagesLoading = true
                return .run { send in
                    let quizPages = try await firebaseService.fetchQuizPages()
                    await send(.delegate(.storeQuizPages(quizPages)))
                    guard let focusPage = quizPages.first(where: { $0.order == index })
                    else { return }

                    await send(.quizResponse(focusPage))
                }

            case .quizResponse(let quizPage):
                state.pagesLoading = false

                return .send(.delegate(.pushNext(quizPage)))

            default:
                return .none
            }
        }
    }
}
