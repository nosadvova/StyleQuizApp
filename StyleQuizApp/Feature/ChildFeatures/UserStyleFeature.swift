//
//  UserStyleFeature.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct UserStyleFeature {

    @ObservableState
    struct State: Equatable {
        var quizPage: QuizPage
        var quizOptionImages: [String: Data] = [:]
        var selectedOptionIDs: Set<String> = []
    }

    enum Action: Equatable {
        case delegate(Delegate)
        case loadImage(String)
        case getImageData(_ optionID: String, _ imageData: Data)

        enum Delegate {
            case pop
        }
    }

    @Dependency(\.firebaseService) var firebaseService

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadImage(let id):
                return .run { send in
                    let imageData = try await firebaseService.fetchQuizImage(id)
                    await send(.getImageData(id, imageData))
                }

            case .getImageData(let id, let data):
                state.quizOptionImages[id] = data
                return .none

            default:
                return .none
            }
        }
    }
}
