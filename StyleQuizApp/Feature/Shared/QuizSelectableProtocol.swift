//
//  QuizSelectableProtocol.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 20.07.2025.
//

import Foundation
import ComposableArchitecture

protocol QuizSelectableProtocol {
    var selectedOptionIDs: Set<String> { get set }
}

extension QuizSelectableProtocol {
    mutating func selectOption(withID optionID: String) {
        if selectedOptionIDs.contains(optionID) {
            selectedOptionIDs.remove(optionID)
        } else {
            selectedOptionIDs.insert(optionID)
        }
    }
}
