import DesignSystem
import Domain
import Foundation
@testable import Presentation
import SwiftUI
import TestExtensions
import Testing

@MainActor
struct HeroDetailViewTests {
    private let sut: HeroDetailView<HeroDetailViewModelProtocolMock>
    private var viewModel = HeroDetailViewModelProtocolMock()

    init() {
        sut = HeroDetailView(viewModel: viewModel)
    }

    @Test func loading() async {
        // Given
        viewModel.state = .loading

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func error() async {
        // Given
        viewModel.state = .error

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loaded() async {
        // Given
        viewModel.state = .loaded(
            HeroDetailViewData(
                name: "AA",
                realName: "ABA",
                image: "BBB",
                deck: "few fewfew",
                creators: ["A", "B", "C"],
                enemies: ["D", "E", "F"],
                friends: ["G", "H", "I"]
            ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loadedWithoutDeckAndRealName() async {
        // Given
        viewModel.state = .loaded(
            HeroDetailViewData(
                name: "AA",
                realName: nil,
                image: "BBB",
                deck: nil,
                creators: ["A", "B", "C"],
                enemies: ["D", "E", "F"],
                friends: ["G", "H", "I"]
            ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
