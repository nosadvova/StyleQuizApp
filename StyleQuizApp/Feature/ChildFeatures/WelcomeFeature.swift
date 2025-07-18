//
//  WelcomeFeature.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WelcomeFeature {

    @ObservableState
    struct State: Equatable {

    }

    enum Action: Equatable {
        case startQuiz
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startQuiz:
                return .none
            }
        }
    }
}
