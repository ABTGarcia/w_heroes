import Testing
import SwiftUI
@testable import Presentation
import TestExtensions
import DesignSystem
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
            HeroCardViewData(id: "1", image: "A", name: "B", description: "EEE"),
            HeroCardViewData(id: "2", image: "A", name: "C", description: "III"),
            HeroCardViewData(id: "3", image: "A", name: "D", description: "OOO")
        ]))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
