//
//  ToolbarContentModifier.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 19.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct ToolbarContentModifier: ViewModifier {
    let title: String
    let onBack: () -> Void

    func body(content: Content) -> some View {
        content
            .toolbar {
                cancelToolbarButton
                toolbarTitleView
            }
    }

    @ToolbarContentBuilder
     private var cancelToolbarButton: some ToolbarContent {
         ToolbarItem(placement: .navigationBarLeading) {
             Button {
                 onBack()
             } label: {
                 Image(.backChevronIcon)
             }

         }
     }

    @ToolbarContentBuilder
     private var toolbarTitleView: some ToolbarContent {
         ToolbarItem(placement: .principal) {
             Text(title.uppercased())
                 .foregroundStyle(.black)
                 .font(.customFont(.poppinsRegular, size: 14))
         }
     }
}
