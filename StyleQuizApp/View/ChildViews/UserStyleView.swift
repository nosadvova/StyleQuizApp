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
                WithPerceptionTracking {
                    GeometryReader { geometry in
                        QuizPageView(quizPage: store.quizPage) {
                            ScrollView(.vertical) {
                                WithPerceptionTracking {
                                    LazyVGrid(columns: columns) {
                                        ForEach(store.quizPage.variants) { option in
                                            QuizOptionCell(quizOption: option, store: store, geometry: geometry)
                                        }
                                    }
                                    .padding(.bottom, 20)
                                }
                            }
                        } onContinue: {
                            store.send(.delegate(.pushNext(store.nextPageIndex)))
                        }
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 22, trailing: 20))
                        .frame(maxWidth: .infinity, alignment: .top)
                    }
                }
            }
            .modifier(ToolbarContentModifier(title: localized(.stylePreferences).uppercased(), onBack: {
                store.send(.pop)
            }))
            .scrollIndicators(.hidden)
            .navigationBarBackButtonHidden()
            .onAppear {
                store.send(.onAppearLoad)
            }
        }
    }
}

private struct QuizOptionCell: View {
    let quizOption: QuizOptions
    let store: StoreOf<UserStyleFeature>
    let geometry: GeometryProxy

    var optionSelected: Bool {
        return store.selectedOptionIDs.contains(quizOption.id)
    }

    var body: some View {
        WithPerceptionTracking {
            Button {
                store.send(.selectOption(quizOption.id))
            } label: {
                VStack(alignment: .center, spacing: 4) {
                    if let data = store.state.quizOptionImages[quizOption.id], let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 2.5, height: 120)
                            .clipped()
                    } else {
                        ProgressView()
                            .frame(width: geometry.size.width / 2.5, height: 120)
                    }

                    Text(quizOption.title.uppercased())
                        .font(.customFont(optionSelected ? .poppinsMedium : .poppinsLight, size: 13))
                }
                .overlay(alignment: .topTrailing) {
                    Image(optionSelected ? .checkedBox : .uncheckedBox)
                }
                .padding(8)
            }
            .buttonStyle(.plain)
            .background {
                Rectangle()
                    .stroke(optionSelected ? .strokePrimary : .strokeSecondary, lineWidth: 0.5)
            }
        }
    }
}
