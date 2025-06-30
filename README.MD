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
- [Changelog](#changelog)
- [More](#more)

---

## ✨ Features
- Browse a list of Marvel heroes
- View detailed information for each hero
- Search hero by name

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
  - [Maestro](https://maestro.mobile.dev/)


### 🤖 UI Automation (Maestro)

This project includes UI automation tests using [Maestro](https://maestro.mobile.dev/), a modern open-source mobile UI testing framework.

#### 🚦 How to Run Maestro Tests

1. **Install Maestro CLI** (if not already installed):
   ```bash
    brew tap mobile-dev-inc/tap
    brew install maestro
   ```

2. **Run a Maestro test flow:**
   ```bash
   maestro test Maestro/Search.yml
   maestro test Maestro/Navigation.yml
   ```

#### 📝 What the Tests Cover
- **Search.yml**: Launches the app, searches for heroes, verifies search results, navigates to hero details, and checks for correct UI elements.
- **Navigation.yml**: Launches the app, navigates to hero details, verifies content, scrolls to specific heroes, and checks navigation back and forth.

---

## 📝 Changelog

### **v1.0.0**
- Add basic list of heroes
- Add basic Detail of heroes


### **v1.1.0**
 - Add Postman collection
 - Improve loading animation
 - Improve Heroes List UI
 - Improve Heroes Detail UI
 - Add Search feature
 - Improve API query to get the only necessary fields

### **v1.2.0**
 - Bugfix of retry button in error page
 - Update Postman collection
 - Improve accessibility
 - Add Maestro tests
 - Show error when load more in HeroesList
 - Improve navigation
 - Bugfix realname in HeroDetail


## 👀 More
- Marvel API documentation was not running, returning constantly errors and I couldn't even use it. Instead of that API, I used [ComicVine API](https://comicvine.gamespot.com/api/), even if it's not wonderful, it works pretty well for this technical challenge. To help you a little bit, I added a Postman collection in the root of this project. Please, feel free to use it, including my own API Key 😁
- Due to API's connection, sometimes Maestro tests are not working successfully :(
- What about IA? Yes, I used Cursor basically in 2 things: to help me with the loading animation and to improve README.MD file. Also I used ChatGPT and Google to help me with some doubts and information.
