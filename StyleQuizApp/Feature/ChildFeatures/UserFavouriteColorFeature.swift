//
//  UserFavouriteColorFeature.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import UIKit
import ComposableArchitecture

@Reducer
struct UserFavouriteColorFeature {
    
    @ObservableState
    struct State: Equatable, QuizSelectableProtocol {
        var quizPage: QuizPage
        var selectedOptionIDs: Set<String> = []
    }
    
    enum Action: Equatable {
        case selectOption(String)
        case delegate(Delegate)
        case pop

        enum Delegate: Equatable {
            case pushNext(QuizPage)
            case popToRoot
        }
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.userDefaultsService) var userDefaults

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .pop:
                return .run { _ in await self.dismiss() }

            case .selectOption(let optionID):
                state.selectOption(withID: optionID)
                return .none

            case .delegate(.popToRoot):
                let ids = Array(state.selectedOptionIDs)
                userDefaults.toggleStringInArray("savedAnswers", ids)
                return .none

            default:
                return .none
            }
        }
    }
}
