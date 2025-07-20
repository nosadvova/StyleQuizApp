//
//  UserFavouriteColorView.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 19.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct UserFavouriteColorView: View {
    let store: StoreOf<UserFavouriteColorFeature>

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            WithPerceptionTracking {
                QuizPageView(quizPage: store.quizPage) {
                    ScrollView(.vertical) {
                        WithPerceptionTracking {
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(store.quizPage.variants) { option in
                                    QuizOptionCell(quizOption: option, store: store)
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }
                } onContinue: {
                    store.send(.delegate(.popToRoot))
                }
                .padding(EdgeInsets(top: 16, leading: 20, bottom: 22, trailing: 20))
                .frame(maxWidth: .infinity, alignment: .top)
            }
        }
        .modifier(ToolbarContentModifier(title: localized(.stylePreferences).uppercased(), onBack: {
            store.send(.pop)
        }))
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
    }
}

private struct QuizOptionCell: View {
    let quizOption: QuizOptions
    let store: StoreOf<UserFavouriteColorFeature>

    var optionSelected: Bool {
        return store.selectedOptionIDs.contains(quizOption.id)
    }

    var body: some View {
        WithPerceptionTracking {
            Button {
                store.send(.selectOption(quizOption.id))
            } label: {
                VStack(alignment: .center, spacing: 8) {
                    Rectangle()
                        .fill(Color(quizOption.id))
                        .frame(width: 32, height: 32)

                    Text(quizOption.title.uppercased())
                        .font(.customFont(optionSelected ? .poppinsMedium : .poppinsLight, size: 13))
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .overlay(alignment: .topTrailing) {
                    Image(.checkedBox)
                        .opacity(optionSelected ? 1 : 0)
                        .padding([.top, .trailing], 8)
                }
            }
            .buttonStyle(.plain)
            .background {
                Rectangle()
                    .stroke(optionSelected ? .strokePrimary : .strokeSecondary, lineWidth: 0.5)
            }
        }
    }
}
