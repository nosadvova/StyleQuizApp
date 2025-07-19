//
//  UserFocusView.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 19.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct UserFocusView: View {
    let store: StoreOf<UserFocusFeature>

    var body: some View {
        WithPerceptionTracking {
            NavigationView {
                QuizPageView(quizPage: store.page) {
                    List {
                        ForEach(store.page.variants) { variant in
                            QuizOptionCell(quizOption: variant, store: store)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                } onContinue: {
//                    store.send(.)
                }
                .padding(EdgeInsets(top: 16, leading: 20, bottom: 22, trailing: 20))
            }
            .navigationBarBackButtonHidden()
            .modifier(ToolbarContentModifier(title: localized(.lifestyleAndInterests)) {
                store.send(.delegate(.pop))
            })
        }
    }
}

private struct QuizOptionCell: View {
    let quizOption: QuizOptions
    let store: StoreOf<UserFocusFeature>

    var optionSelected: Bool {
        store.selectedOptionIDs.contains(quizOption.id)
    }

    var body: some View {
        WithPerceptionTracking {
            Button {
                store.send(.selectOption(quizOption.id))
            } label: {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(quizOption.title)
                            .font(.customFont(.poppinsMedium, size: 13))
                        
                        Text(quizOption.description ?? "")
                            .font(.customFont(.poppinsLight, size: 14))
                    }

                    Spacer()

                    Image(optionSelected ? .checkedBox : .uncheckedBox)
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 15, leading: 16, bottom: 15, trailing: 16))
            }
            .buttonStyle(.plain)
            .background {
                Rectangle()
                    .stroke(optionSelected ? .strokePrimary : .strokeSecondary, lineWidth: 0.5)
            }
        }
    }
}

