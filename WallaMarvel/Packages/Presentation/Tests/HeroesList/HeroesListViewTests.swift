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
        viewModel = HeroesListViewModelProtocolMock()
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
            heroes: [Hero(id: "1", image: "A", thumbnail: "F", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")],
            isLoading: false,
            searchList: []
        ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loadedSearch() async throws {
        // Given
        viewModel.state = .loaded(HeroesListViewData(
            heroes: [Hero(id: "1", image: "A", thumbnail: "F", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")],
            isLoading: false,
            searchList: [SearchResultsCardViewData(id: "", name: "AA", thumbnail: "", apiDetailUrl: "")]
        ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loadedLoading() async throws {
        // Given
        viewModel.state = .loaded(HeroesListViewData(
            heroes: [Hero(id: "1", image: "A", thumbnail: "G", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")],
            isLoading: true,
            searchList: []
        ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loadedError() async throws {
        // Given
        viewModel.state = .loaded(HeroesListViewData(
            heroes: [Hero(id: "1", image: "A", thumbnail: "G", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")],
            isLoading: false,
            searchList: [],
            hasError: true
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
