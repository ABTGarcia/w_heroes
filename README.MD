# Wallapop Heroes

**Wallapop Heroes** is a modern iOS app to browse and search for Marvel superheroes, built with Swift, SwiftUI, and a modular architecture. It supports offline access, dark mode, and robust UI testing.

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
- Show previously displayed content without connection (offline support)
- Dark mode available

---

## 📋 Requirements
- Xcode 16.2 or later  
- iOS 18.0 or later  
- Swift 6.0 or later  

---

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ABTGarcia/w_heroes
   cd wallapop-heroes
   ```

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
   - (For mock generation) Install [Sourcery](https://github.com/krzysztofzablocki/Sourcery):
     ```bash
     brew install sourcery
     ```

3. **Open the project**
   - Open `WallaMarvel.xcodeproj` in Xcode.
   - Build and run the app on the simulator or a device.

---

## ▶️ Usage
- Launch the app to browse and search for Marvel heroes.
- Tap a hero to view detailed information.
- Use the top bar to search a hero by name

---

## 🏗 Architecture

The app uses a modular, scalable architecture based on **MVVM (Model-View-ViewModel)**. The main modules are:

- **Domain**: Business logic, use cases, and models.
- **Data**: Data sources (remote/local), repositories, networking, and entity mapping.
- **Presentation**: SwiftUI views, view models, and navigation.
- **DesignSystem**: UI components, colors, fonts, and assets.
- **TestExtensions**: Utilities for testing and snapshotting.

Each module is implemented as a Swift Package for separation of concerns and reusability.

---

## ✅ Testing

- **Unit Tests**: Run via Xcode's test navigator or `Cmd+U`.
- **Snapshot Tests**: Ensure UI consistency. Use iPhone 16 Pro simulator with iOS 18.2, Dark Appearance disabled, and English language.
- **Mocking**: Protocol mocks are generated using Sourcery.
- **UI Automation**: See Maestro section below.

### 🤖 UI Automation (Maestro)

This project includes UI automation tests using [Maestro](https://maestro.mobile.dev/).

#### 🚦 How to Run Maestro Tests

1. **Install Maestro CLI**:
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
- **Search.yml**: Search, view details, and navigation.
- **Navigation.yml**: Navigation and scrolling.

---

## 📝 Changelog

### **v1.3.0**
 - Display local stored data when there's no connection
 - Cached images displayed
 - Bugfix touchable area in search results
 - Improve search with loading display

### **v1.2.0**
 - Bugfix of retry button in error page
 - Update Postman collection
 - Improve accessibility
 - Add Maestro tests
 - Show error when load more in HeroesList
 - Improve navigation
 - Bugfix realname in HeroDetail

### **v1.1.0**
 - Add Postman collection
 - Improve loading animation
 - Improve Heroes List UI
 - Improve Heroes Detail UI
 - Add Search feature
 - Improve API query to get the only necessary fields

### **v1.0.0**
- Add basic list of heroes
- Add basic Detail of heroes

---

## 👀 More
- Marvel API documentation was not running, returning constant errors, so [ComicVine API](https://comicvine.gamespot.com/api/) was used instead.
- A Postman collection is included in the root of this project.
- Sometimes Maestro tests may fail due to API connection issues.
- AI tool were used to help me with the loading animation and to improve README.MD 
