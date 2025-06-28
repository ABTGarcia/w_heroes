# Wallapop Heroes

**Wallapop Heroes** is an iOS app that lets you browse information about your favorite Marvel superheroes. Built with Swift and SwiftUI, it features a clean architecture and modern development practices.

---

## 📖 Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Architecture](#architecture)
- [Testing](#testing)

---

## ✨ Features
- Browse a list of Marvel heroes
- View detailed information for each hero

---

## 📋 Requirements
- Xcode 16.2 or later  
- iOS 18.0 or later  
- Swift 6.0 or later  

---

## 🚀 Installation

1. **Clone the repository**

2. **Install dependencies**
    - Install [Homebrew](https://brew.sh) (if not installed):
      ```bash
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ```
    - Install [SwiftLint](https://github.com/realm/SwiftLint):
      ```bash
      brew install swiftlint
      ```
    - Install [SwiftFormat](https://github.com/nicklockwood/SwiftFormat):
      ```bash
      brew install swiftformat
      ```
    - (For code generation) Install [Sourcery](https://github.com/krzysztofzablocki/Sourcery):
      ```bash
      brew install sourcery
      ```

3. **Run the project**
    - Open the project in XCode, build and run the app on the simulator or a device.

---

## ▶️ Usage
- Launch the app to browse and search for Marvel heroes.
- Tap a hero to view detailed information.

---

## 🏗 Architecture

The app uses a modular, scalable architecture based on **MVVM (Model-View-ViewModel)**. The main modules are:

- **Domain**: Business logic, use cases, and models.
- **Data**: Data sources, repositories, networking, and entity mapping.
- **Presentation**: SwiftUI views, view models, and navigation.
- **DesignSystem**: UI components, colors, fonts, and assets.
- **TestExtensions**: Utilities for testing and snapshotting.

Each module is implemented as a Swift Package for separation of concerns and reusability.

---

## ✅ Testing

The codebase is designed with testability in mind. Unit and snapshot tests are included.

- **Unit Tests**: Run via Xcode's test navigator or `Cmd+U`.
- **Snapshot Tests**: Ensure UI consistency. To pass all snapshot tests, use the iPhone 16 Pro simulator with iOS 18.2, Dark Appearance disabled, and English language.
- **Mocking**: Protocol mocks are generated using Sourcery. Run `sourcery` from the project root to generate mocks for protocols marked with `// sourcery: Automockable`.
- **Test Frameworks**:
  - [Swift Testing](https://developer.apple.com/documentation/testing)
  - [Snapshot Testing](https://github.com/pointfreeco/swift-snapshot-testing)
  - [Sourcery](https://github.com/krzysztofzablocki/Sourcery)
