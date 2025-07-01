@testable import DesignSystem
import SwiftUI
import TestExtensions
import Testing

@MainActor
struct SearchFieldViewTests {
    private var searchFieldViewModel = SearchFieldViewModelProtocolMock()

    init() {
        searchFieldViewModel.state = .hidden
    }

    @Test func withSearchText() async throws {
        // Given
        let sut = SearchFieldView(searchText: Binding.constant("AA"), viewModel: searchFieldViewModel, tapClosure: { _ in })

        // Then
        expectSnapshot(matching: sut)
    }

    @Test func withoutSearchText() async throws {
        // Given
        let sut = SearchFieldView(searchText: Binding.constant(""), viewModel: searchFieldViewModel, tapClosure: { _ in })

        // Then
        expectSnapshot(matching: sut)
    }

    @Test func loading() async throws {
        // Given
        searchFieldViewModel.state = .loading
        let sut = SearchFieldView(searchText: Binding.constant("AA"), viewModel: searchFieldViewModel, tapClosure: { _ in })

        // Then
        expectSnapshot(matching: sut)
    }

    @Test func error() async throws {
        // Given
        searchFieldViewModel.state = .error
        let sut = SearchFieldView(searchText: Binding.constant("AA"), viewModel: searchFieldViewModel, tapClosure: { _ in })

        // Then
        expectSnapshot(matching: sut)
    }

    @Test func noResults() async throws {
        // Given
        searchFieldViewModel.state = .noResults
        let sut = SearchFieldView(searchText: Binding.constant("AA"), viewModel: searchFieldViewModel, tapClosure: { _ in })

        // Then
        expectSnapshot(matching: sut)
    }

    @Test func loaded() async throws {
        // Given
        let data = [SearchResultsCardViewData(id: "1", name: "SS", thumbnail: "EE", apiDetailUrl: "FG")]
        searchFieldViewModel.state = .loaded(data)
        let sut = SearchFieldView(searchText: Binding.constant("AA"), viewModel: searchFieldViewModel, tapClosure: { _ in })

        // Then
        expectSnapshot(matching: sut)
    }
}
