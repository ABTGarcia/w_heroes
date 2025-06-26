import Testing
import SwiftUI
@testable import Presentation
import TestExtensions
import Foundation

@MainActor
struct HeroesListViewTests {
    private let sut: HeroesListView

    init() {
        sut = HeroesListView()
    }

    @Test func body() async throws {
        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
