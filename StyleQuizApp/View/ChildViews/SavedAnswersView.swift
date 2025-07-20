//
//  SavedAnswersView.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 20.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct SavedAnswersView: View {
    let store: StoreOf<SavedAnswersFeature>

    var body: some View {
        NavigationView {
            WithPerceptionTracking {
                ScrollView(.vertical) {
                    ForEach(store.savedAnswers) { option in
                        QuizHistoryCell(quizOption: option)
                    }
                }
                .padding([.horizontal, .top], 10)
                .onAppear {
                    store.send(.fetchAnswers)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .scrollIndicators(.hidden)
        .modifier(ToolbarContentModifier(title: "Quiz history", onBack: {
            store.send(.pop)
        }))
    }
}

private struct QuizHistoryCell: View {
    let quizOption: QuizOptions

    var body: some View {
        HStack(spacing: 16) {
            Group {
                if let data = quizOption.imageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipped()
                        .cornerRadius(6)
                } else if quizOption.colorName != nil {
                    Rectangle()
                        .fill(Color(quizOption.id))
                        .frame(width: 32, height: 32)
                        .cornerRadius(6)
                } else {
                    EmptyView()
                }
            }

            Text(quizOption.title)
                .font(.customFont(.poppinsRegular, size: 14))
                .foregroundStyle(.primary)

            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.strokeSecondary, lineWidth: 0.5)
        }
    }
}
