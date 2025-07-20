//
//  SavedAnswersFeature.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 20.07.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SavedAnswersFeature {

    @ObservableState
    struct State: Equatable {
        var savedAnswers: [QuizOptions] = []
        var quizPages: [QuizPage]
        var quizOptionImages: [String: Data] = [:]

        // dictionary with image data with id key
    }

    enum Action: Equatable {
        case fetchQuizPages([QuizPage])
        case fetchAnswers
        case displayAnswers([QuizOptions])
        case getImageData(_ optionID: String, _ imageData: Data)
        case pop
    }

    @Dependency(\.firebaseService) var firebaseService
    @Dependency(\.userDefaultsService) var userDefaults
    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchAnswers:
                return .run { send in
                    let fetchedPages = try await firebaseService.fetchQuizPages()
                    await send(.fetchQuizPages(fetchedPages))
                }

            case .fetchQuizPages(let pages):
                let answers = userDefaults.loadStringArray("savedAnswers") ?? []

                let mergedAnswers = pages.flatMap { $0.variants }
                let filteredOptions = mergedAnswers.filter { answers.contains($0.id) }
                return .send(.displayAnswers(filteredOptions))

            case .displayAnswers(let options):
                state.savedAnswers = options
                return .none

            case .pop:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
