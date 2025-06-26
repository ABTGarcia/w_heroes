import Testing
import SwiftUI
@testable import Presentation
import TestExtensions
import Foundation

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
        viewModel.state = .loaded(HeroesListViewData(list: [
            HeroeViewData(id: "1", image: "A", name: "B"),
            HeroeViewData(id: "2", image: "A", name: "C"),
            HeroeViewData(id: "3", image: "A", name: "D")
        ]))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
