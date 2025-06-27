import Testing
import SwiftUI
@testable import Presentation
import TestExtensions
import DesignSystem
import Foundation
import Domain

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
            model: HeroesList(
                heroes: [Hero(id: "1", image: "A", name: "B", description: "C")],
                pagination: Pagination(offset: 1, limit: 2, total: 3))))

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
