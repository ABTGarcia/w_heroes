# Wallapop Heroes

**Wallapop Heroes** is an iOS app that lets you browse information about your favorite Marvel superheroes.

## ✨ Features

- Displays a list of Marvel heroes.
- Shows detailed information for each hero.

## 📋 Requirements

- Xcode 16.2 or later  
- iOS 18.0 or later  
- Swift 6.0 or later  

## 🚀 Installation

1. **Clone the repository**
    ```bash
    git clone https://github.com/ABTGarcia/w_heroes
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

    - Install [Sourcery](https://github.com/krzysztofzablocki/Sourcery) (only if you want to modify some tests):
      ```bash
      brew install sourcery
      ```

3. **Open the project in Xcode**
    - Build and run the app on the simulator or a device.

## 🏗 Architecture

The app is built using the **MVVM (Model-View-ViewModel)** architecture.  
You can learn more about MVVM [here](https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project).

## ✅ Testing

The codebase is designed with testability in mind. We encourage writing and running unit tests to ensure the app’s reliability and maintainability.

To accomplish this objective, we will use this frameworks:
- [Swift Testing](https://developer.apple.com/documentation/testing)
- [Snapshot Testing](https://github.com/pointfreeco/swift-snapshot-testing)
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

### About mocking protocols

Thanks to Sourcery we can create automatically mocks from protocols. To do that, we have to run the command ```sourcery``` from the project's root folder and it will create the mocks of the protocols that are marked with ```// sourcery: Automockable```.

In order to modify the path of the mocks, imports, sourcefolders, etc... check the file .sourcery.yml in the root folder.

### Snapshot Testing
To successfully pass all the snapshot tests, the battery must be executed using iPhone 16 Pro simulator with iOS 18.2, with Dark Appearance disabled and in English language.