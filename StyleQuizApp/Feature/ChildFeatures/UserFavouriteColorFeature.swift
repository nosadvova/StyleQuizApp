//
//  UserFavouriteColorFeature.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct UserFavouriteColorFeature {

    @ObservableState
    struct State: Equatable {

    }

    enum Action: Equatable {

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                    .none
            }
        }
    }
}
