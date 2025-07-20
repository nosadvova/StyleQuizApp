//
//  QuizModel.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation
import FirebaseFirestore

struct QuizPage: Codable, Identifiable {
    var id = UUID().uuidString
    let order: Int
    let title: String
    let description: String?
    let type: QuizType
    var variants: [QuizOptions]

    static let quizTitles: [String] = [
        "Casual",
        "Boho",
        "Classy",
        "Ladylike",
        "Urban",
        "Sporty"
    ]

    static let textQuiz = QuizPage(
        order: 0,
        title: "What’d you like our stylists to focus on?",
        description: "We offer services via live-chat mode.",
        type: .text,
        variants: [
            QuizOptions(
                title: "REINVENT WARDROBE",
                description: "to discover fresh outfit ideas",
                imageData: nil,
                colorName: nil
            ),
            QuizOptions(
                title: "DEFINE COLOR PALETTE",
                description: "to enhance my natural features",
                imageData: nil,
                colorName: nil
            ),
            QuizOptions(
                title: "CREATE A SEASONAL CAPSULE",
                description: "to curate effortless and elegant looks",
                imageData: nil,
                colorName: nil
            ),
            QuizOptions(
                title: "DEFINE MY STYLE",
                description: "to discover my signature look",
                imageData: nil,
                colorName: nil
            ),
            QuizOptions(
                title: "CREATE AN OUTFIT FOR AN EVENT",
                description: "to own a spotlight wherever you go",
                imageData: nil,
                colorName: nil
            )
        ]
    )

    static func stylePage(titles: [String]) -> QuizPage {
        return QuizPage(
            order: 1,
            title: "Which style best represents you?",
            description: nil,
            type: .image,
            variants: (0...5).map { i in
                QuizOptions(
                    title: quizTitles[i],
                    description: nil,
                    imageData: UIImage(named: "\(i)")?.pngData(),
                    colorName: nil
                )
            }
        )
    }

    static let colorPage = QuizPage(
        order: 2,
        title: "Choose favourite colors",
        description: nil,
        type: .color,
        variants: [
            QuizOptions(id: "beige", title: "Beige", description: nil, imageData: nil, colorName: "#D7A98C"),
            QuizOptions(id: "blue", title: "Blue", description: nil, imageData: nil, colorName: "#007AFF"),
            QuizOptions(id: "brown", title: "Brown", description: nil, imageData: nil, colorName: "#8B4513"),
            QuizOptions(id: "emerald", title: "Emerald", description: nil, imageData: nil, colorName: "#50C878"),
            QuizOptions(id: "green", title: "Green", description: nil, imageData: nil, colorName: "#34C759"),
            QuizOptions(id: "indigo", title: "Indigo", description: nil, imageData: nil, colorName: "#5856D6"),
            QuizOptions(id: "light_blue", title: "Light Blue", description: nil, imageData: nil, colorName: "#5AC8FA"),
            QuizOptions(id: "magenta", title: "Magenta", description: nil, imageData: nil, colorName: "#FF2D55"),
            QuizOptions(id: "mint", title: "Mint", description: nil, imageData: nil, colorName: "#00C7BE"),
            QuizOptions(id: "olive", title: "Olive", description: nil, imageData: nil, colorName: "#808000"),
            QuizOptions(id: "orange", title: "Orange", description: nil, imageData: nil, colorName: "#FF9500"),
            QuizOptions(id: "pink", title: "Pink", description: nil, imageData: nil, colorName: "#FF2D55"),
            QuizOptions(id: "red", title: "Red", description: nil, imageData: nil, colorName: "#FF3B30"),
            QuizOptions(id: "turquoise", title: "Turquoise", description: nil, imageData: nil, colorName: "#40E0D0"),
            QuizOptions(id: "yellow", title: "Yellow", description: nil, imageData: nil, colorName: "#FFD60A")
        ]
    )
}

extension QuizPage: Equatable {
    static func == (lhs: QuizPage, rhs: QuizPage) -> Bool {
        lhs.id == rhs.id
    }
}

enum QuizType: String, Codable {
    case text
    case image
    case color
}

struct QuizOptions: Codable, Identifiable, Equatable {
    var id = UUID().uuidString
    let title: String
    let description: String?
    var imageData: Data?
    var colorName: String?
}
