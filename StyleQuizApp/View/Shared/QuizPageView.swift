//
//  QuizPageView.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 19.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct QuizPageView<Content>: View where Content: View {
    let quizPage: QuizPage
    let content: () -> Content
    let onContinue: () -> Void
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                Group {
                    Text(quizPage.title)
                        .font(.customFont(.kaisenMedium, size: 26))
                        .multilineTextAlignment(.leading)
                    
                    if let description = quizPage.description {
                        Text(description)
                            .font(.customFont(.poppinsLight, size: 14))
                            .padding(.top, 8)
                    }
                }

                ZStack(alignment: .bottom) {
                    content()
                        .padding(.top, 24)
                    
                    Button(localized(.continueLabel).uppercased()) {
                        onContinue()
                    }
                    .buttonStyle(SquareButtonStyle())
                }
            }
        }
    }
}
