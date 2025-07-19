//
//  SquareButtonStyle.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 19.07.2025.
//

import SwiftUI

struct SquareButtonStyle: ButtonStyle {
    let tint: Color
    let foregroundStyle: Color

    init(tint: Color = .black, foregroundStyle: Color = .white) {
        self.tint = tint
        self.foregroundStyle = foregroundStyle
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundStyle)
            .font(.customFont(.poppinsRegular, size: 14))
            .frame(width: 350, height: 48)
            .background {
            Rectangle()
                    .fill(tint)
        }
    }
}
