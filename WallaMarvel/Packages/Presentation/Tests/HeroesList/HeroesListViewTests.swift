import DesignSystem
import Domain
import Foundation
@testable import Presentation
import SwiftUI
import TestExtensions
import Testing

@MainActor
struct HeroesListViewTests {
    private let sut: HeroesListView<HeroesListViewModelProtocolMock>
    private var viewModel = HeroesListViewModelProtocolMock()

    init() {
        sut = HeroesListView(viewModel: viewModel)
    }

    @Test func loading() async throws {
        // Given
        viewModel.state = .loading

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loaded() async throws {
        // Given
        viewModel.state = .loaded(HeroesListViewData(
            heroes: [Hero(id: "1", image: "A", name: "B", description: "C")],
            isLoading: false
        ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loadedLoading() async throws {
        // Given
        viewModel.state = .loaded(HeroesListViewData(
            heroes: [Hero(id: "1", image: "A", name: "B", description: "C")],
            isLoading: true
        ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func error() async throws {
        // Given
        viewModel.state = .error

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
