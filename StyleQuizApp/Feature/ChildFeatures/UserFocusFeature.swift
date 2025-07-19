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
    struct State: Equatable {
        var page: QuizPage
        var selectedOptionIDs: [String]
    }

    enum Action: Equatable {
        case selectOption(String)
        case delegate(Delegate)

        enum Delegate {
            case pop
            case pushNext
        }
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .selectOption(let optionID):
                if state.selectedOptionIDs.contains(optionID) {
                    state.selectedOptionIDs.removeAll { $0 == optionID }
                } else {
                    state.selectedOptionIDs.append(optionID)
                }
                return .none

            default:
                return .none
            }
        }
    }
}
