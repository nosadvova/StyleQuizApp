//
//  Font+Extension.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 19.07.2025.
//

import SwiftUI

enum FontType: String {
    case kaisenBold = "KaiseiTokumin-Bold"
    case kaisenExtraBold = "KaiseiTokumin-ExtraBold"
    case kaisenMedium = "KaiseiTokumin-Medium"
    case kaisenRegular = "KaiseiTokumin-Regular"

    case poppinsMedium = "Poppins-Medium"
    case poppinsRegular = "Poppins-Regular"
    case poppinsLight = "Poppins-Light"

    var fontWeight: Font.Weight {
        switch self {
        case .kaisenBold:
            return .bold
        case .kaisenExtraBold:
            return .black
        case .kaisenMedium:
            return .medium
        case .kaisenRegular:
            return .regular
        case .poppinsMedium:
            return .medium
        case .poppinsRegular:
            return .regular
        case .poppinsLight:
            return .light
        }
    }
}

extension Font {
    static func customFont(_ type: FontType, size: CGFloat) -> Font {
        return Font.custom(type.rawValue, size: size)
            .weight(type.fontWeight)
    }
}
