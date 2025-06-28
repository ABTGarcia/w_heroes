import Testing
import SwiftUI
@testable import Presentation
import TestExtensions
import DesignSystem
import Foundation
import Domain

@MainActor
struct HeroDetailViewTests {
    private let sut: HeroDetailView<HeroDetailViewModelProtocolMock>
    private var viewModel = HeroDetailViewModelProtocolMock()

    init() {
        sut = HeroDetailView(viewModel: viewModel)
    }

    @Test func loading() async throws {
        // Given
        viewModel.state = .loading

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func error() async throws {
        // Given
        viewModel.state = .error

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loaded() async throws {
        // Given
        viewModel.state = .loaded(
            HeroDetailViewData(
                id: "1",
                name: "AA",
                image: "BBB",
                deck: "few fewfew",
                creators: ["A", "B", "C"],
                enemies: ["D", "E", "F"],
                friends: ["G", "H", "I"]))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
