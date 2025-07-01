import DesignSystem
import Domain
import Foundation
@testable import Presentation
import SwiftUI
import TestExtensions
import Testing

@MainActor
struct HeroesListViewTests {
    private let sut: HeroesListView<HeroesListViewModelProtocolMock, SearchFieldViewModelProtocolMock>
    private var heroesListViewModel = HeroesListViewModelProtocolMock()
    private var searchFieldViewModel = SearchFieldViewModelProtocolMock()

    init() {
        searchFieldViewModel.state = .hidden
        sut = HeroesListView(heroesListViewModel: heroesListViewModel, searchViewModel: searchFieldViewModel)
    }

    @Test func loading() async throws {
        // Given
        heroesListViewModel.state = .loading

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loaded() async throws {
        // Given
        heroesListViewModel.state = .loaded(HeroesListViewData(
            heroes: [Hero(id: "1", image: "A", thumbnail: "F", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")],
            isLoading: false,
            searchList: []
        ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loadedLoading() async throws {
        // Given
        heroesListViewModel.state = .loaded(HeroesListViewData(
            heroes: [Hero(id: "1", image: "A", thumbnail: "G", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")],
            isLoading: true,
            searchList: []
        ))

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func loadedError() async throws {
        // Given
        heroesListViewModel.state = .loaded(HeroesListViewData(
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
        heroesListViewModel.state = .error

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
