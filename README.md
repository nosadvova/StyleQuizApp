# StyleQuizApp

A SwiftUI-based iOS application built using [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture), designed to guide users through a dynamic quiz that adapts content and structure from Firebase.

The goal of this app is to help users identify their style preferences via an interactive quiz and optionally visualize their answer history.

---

## 🧠 Features

- **Modular architecture with TCA (using `@Reducer` macros and `Perception` to work with macroses under iOS version 17.0)**
- **Dynamic quiz** with pages and options loaded from **Firebase Firestore**
- **Navigation** with `StackState`
- **Answer persistence** using `@Dependency(\.userDefaults)` with custom service
- **Styling** with custom fonts and UI components
