//
//  StyleQuizAppApp.swift
//  StyleQuizApp
//
//  Created by Vova Novosad on 18.07.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import ComposableArchitecture

@main
struct StyleQuizAppApp: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppFeature.State(), reducer: {
                AppFeature()
            }))
        }
    }
}
