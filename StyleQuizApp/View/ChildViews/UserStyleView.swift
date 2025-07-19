//
//  UserStyleView.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 19.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct UserStyleView: View {
    let store: StoreOf<UserStyleFeature>

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        WithPerceptionTracking {
            NavigationView {
                QuizPageView(quizPage: store.quizPage) {
                    LazyVGrid(columns: columns) {
                        ForEach(store.quizPage.variants) { option in
                            QuizOptionCell(quizOption: option, store: store)
                        }
                    }
                } onContinue: {
                    //
                }
            }
        }
    }
}

private struct QuizOptionCell: View {
    let quizOption: QuizOptions
    let store: StoreOf<UserStyleFeature>

    var optionSelected: Bool {
        return store.selectedOptionIDs.contains(quizOption.id)
    }

    var body: some View {
        WithPerceptionTracking {
            Button {
                //
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    if let data = store.state.quizOptionImages[quizOption.id], let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }

                    Text(quizOption.title)
                        .font(.customFont(optionSelected ? .poppinsMedium : .poppinsLight, size: 13))
                }
                .overlay(alignment: .topTrailing) {
                    Image(optionSelected ? .checkedBox : .uncheckedBox)
                }
                .padding(8)
            }
//            .frame(maxWidth: .infinity)
//            .padding(EdgeInsets(top: 15, leading: 16, bottom: 15, trailing: 16))
        }
        .buttonStyle(.plain)
        .background {
            Rectangle()
                .stroke(optionSelected ? .strokePrimary : .strokeSecondary, lineWidth: 0.5)
        }
    }
}
