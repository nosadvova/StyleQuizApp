//
//  WelcomeView.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 20.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct WelcomeView: View {
    let store: StoreOf<WelcomeFeature>

    var body: some View {
        WithPerceptionTracking {
            ZStack {
                Image("welcome_screen_background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                LinearGradient(
                    gradient: Gradient(colors: [
                        .black,
                        .black.opacity(0.9),
                        .clear
                    ]),
                    startPoint: .bottom,
                    endPoint: .center
                )
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 61) {
                    Spacer()

                    Text(localized(.welcomeScreenTitle))
                        .foregroundStyle(.white)
                        .font(.customFont(.kaisenMedium, size: 32))
                        .multilineTextAlignment(.leading)

                    VStack(spacing: 10) {
                        Button(localized(.showQuizHistory).uppercased()) {
                            store.send(.showQuizHistoryTapped)
                        }
                        .buttonStyle(SquareButtonStyle(tint: .emeraldCustom, foregroundStyle: .white))

                        Button(localized(.takeQuiz).uppercased()) {
                            store.send(.startQuizTapped(store.nextPageIndex))
                        }
                        .buttonStyle(SquareButtonStyle(tint: .white, foregroundStyle: .black))
                    }

                }
                .padding(.horizontal, 20)
                .padding(.bottom, 58)
            }
        }
    }
}
