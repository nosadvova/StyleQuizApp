//
//  FirebaseService.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import Foundation
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

final class FirebaseService {
    static let shared = FirebaseService()

    let storage = Storage.storage()
    let database = Firestore.firestore()

    func fetchQuizPages() async throws -> [QuizPage] {
        let snapshot = try await database.collection("quiz_pages").getDocuments()

        guard !snapshot.isEmpty else { return [] }

        var quizPages: [QuizPage] = []
        for document in snapshot.documents {
            do {
                let model = try document.data(as: QuizPage.self)
                quizPages.append(model)
            } catch {
                print(error)
            }
        }
        print(quizPages)
        return quizPages
    }

    func fetchQuizImages(quizOption: QuizOptions, completion: @escaping ((Data?, Error?)) -> Void) {
        let storageRef = storage.reference()
        let folderRef = storageRef.child("styleQuizImages/\(quizOption.id).png")

        folderRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
            completion((data,error))
        }
    }
}
