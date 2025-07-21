//
//  UserFocusFeature.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct UserFocusFeature {

    @ObservableState
    struct State: Equatable, QuizSelectableProtocol {
        var quizPage: QuizPage
        var selectedOptionIDs: Set<String> = []
        let nextPageIndex = 1
    }

    enum Action: Equatable {
        case selectOption(String)
        case pop
        case delegate(Delegate)

        enum Delegate: Equatable {
            case pushNext(Int)
        }
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.userDefaultsService) var userDefaults

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .selectOption(let optionID):
                state.selectOption(withID: optionID)
                return .none

            case .delegate(.pushNext):
                let ids = Array(state.selectedOptionIDs)
                userDefaults.removeValue("savedAnswers")
                userDefaults.toggleStringInArray("savedAnswers", ids)
                return .none

            case .pop:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
