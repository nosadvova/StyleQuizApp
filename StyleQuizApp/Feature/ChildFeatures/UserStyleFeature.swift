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
    struct State: Equatable, QuizSelectableProtocol {
        var quizPage: QuizPage
        var quizOptionImages: [String: Data] = [:]
        var selectedOptionIDs: Set<String> = []

        let nextPageIndex = 2
    }

    enum Action: Equatable {
        case delegate(Delegate)
        case onAppearLoad
        case loadImage(String)
        case getImageData(_ optionID: String, _ imageData: Data)
        case selectOption(String)
        case pop

        enum Delegate: Equatable {
            case pushNext(Int)
        }
    }

    @Dependency(\.firebaseService) var firebaseService
    @Dependency(\.userDefaultsService) var userDefaults
    @Dependency(\.dismiss) var dismiss

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

            case .onAppearLoad:
                let idsToLoad = state.quizPage.variants.compactMap(\.id)
                return .merge(idsToLoad.map { return .send(.loadImage($0)) } )

            case .selectOption(let optionID):
                state.selectOption(withID: optionID)
                return .none

            case .pop:
                return .run { _ in await self.dismiss() }

            case .delegate(.pushNext):
                let ids = Array(state.selectedOptionIDs)
                userDefaults.toggleStringInArray("savedAnswers", ids)

                return .none
            }
        }
    }
}
