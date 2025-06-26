import Testing
import SwiftUI
@testable import Presentation
import SnapshotTesting
import Foundation

@MainActor
struct HeroesListViewTests {
    private let sut: HeroesListView

    init() {
        sut = HeroesListView()
    }

    @Test func body() async throws {
        // Given
        let hostingController = UIHostingController(rootView: sut)

        // Then
        assertSnapshot(
            of: hostingController,
            as: .image(on: .iPhoneSe)
        )
    }
}
