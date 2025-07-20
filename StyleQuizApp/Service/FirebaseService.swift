//
//  FirebaseService.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation
import ComposableArchitecture
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

struct FirebaseService {
    var fetchQuizPages: () async throws -> [QuizPage]
    var fetchQuizImage: (_ optionID: String) async throws -> Data
    var fetchOptionByIDs: (_ pages: [QuizPage], _ optionIDs: [String]) async throws -> [QuizOptions]
}

enum FirebaseServiceKey: DependencyKey {
    static let liveValue: FirebaseService = .live
}

extension DependencyValues {
    var firebaseService: FirebaseService {
        get { self[FirebaseServiceKey.self] }
        set { self[FirebaseServiceKey.self] = newValue }
    }
}

extension FirebaseService {
    static let live = Self(
        fetchQuizPages: {
            let db = Firestore.firestore()
            let snapshot = try await db.collection("quiz_pages")
                .order(by: "order")
                .getDocuments()

            return try snapshot.documents.compactMap {
                try $0.data(as: QuizPage.self)
            }
        },
        fetchQuizImage: { optionID in
            try await withCheckedThrowingContinuation { continuation in
                let storage = Storage.storage()
                let ref = storage.reference()
                    .child("styleQuizImages/\(optionID).png")

                ref.getData(maxSize: 2 * 1024 * 1024) { data, error in
                    if let data = data {
                        continuation.resume(returning: data)
                    } else if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: NSError(domain: "quizImage", code: -1))
                    }
                }
            }
        },
        fetchOptionByIDs: { quizPages, optionIDs in
            let db = Firestore.firestore()
            var options: [QuizOptions] = []

            try await withThrowingTaskGroup(of: QuizOptions.self) { group in
                for id in optionIDs {
                    group.addTask {
                        let doc = try await db.collection("quiz_pages").document(id).getDocument()
                        guard let data = doc.data() else {
                            throw NSError(domain: "Missing document", code: 404)
                        }
                        var decoded = try Firestore.Decoder().decode(QuizOptions.self, from: data)
                        decoded.id = doc.documentID
                        return decoded
                    }
                }

                for try await option in group {
                    options.append(option)
                }
            }

            return options
        }
    )
}

extension FirebaseService {
    static let mock = Self(
        fetchQuizPages: {
            [
                QuizPage(
                    order: 0,
                    title: "Choose your goal",
                    description: nil,
                    type: .text,
                    variants: [
                        QuizOptions(id: "reinvent", title: "Reinvent", description: "Fresh outfits", imageData: nil, colorName: nil)
                    ]
                )
            ]
        },

        fetchQuizImage: { _ in Data() },

        fetchOptionByIDs: { _, _ in QuizPage.colorPage.variants }
    )
}

//    let storage = Storage.storage()
//    let database = Firestore.firestore()
//
//    func fetchQuizPages() async throws -> [QuizPage] {
//        let snapshot = try await database.collection("quiz_pages").getDocuments()
//
//        guard !snapshot.isEmpty else { return [] }
//
//        var quizPages: [QuizPage] = []
//        for document in snapshot.documents {
//            do {
//                let model = try document.data(as: QuizPage.self)
//                quizPages.append(model)
//            } catch {
//                print(error)
//            }
//        }
//        print(quizPages)
//        return quizPages
//    }
//
//    func fetchQuizImages(quizOption: QuizOptions, completion: @escaping ((Data?, Error?)) -> Void) {
//        let storageRef = storage.reference()
//        let folderRef = storageRef.child("styleQuizImages/\(quizOption.id).png")
//
//        folderRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
//            completion((data,error))
//        }
//    }
//}
