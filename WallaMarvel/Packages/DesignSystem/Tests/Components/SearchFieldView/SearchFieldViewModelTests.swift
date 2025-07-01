@testable import DesignSystem
import Domain
import FactoryKit
import SwiftUI
import Testing

@MainActor
struct SearchFieldViewModelTests {
    private var sut: SearchFieldViewModel!
    private let container: Container
    private var searchHeroByNameUseCaseProtocolMock = SearchHeroByNameUseCaseProtocolMock()

    private let searchResult = [SearchResultsCardViewData(id: "1", name: "B", thumbnail: "F", apiDetailUrl: "J")]
    private let heroes = [Hero(id: "1", image: "A", thumbnail: "F", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")]
    init() {
        container = Container()
        setDependencies()
        sut = SearchFieldViewModel(container: container)
    }

    @Test func searchTextChanged() async throws {
        // Given
        searchHeroByNameUseCaseProtocolMock.invokeReturnValue = heroes

        // When
        await sut.process(.searchTextChanged("A"))

        // Then
        #expect(sut.state == .loaded(searchResult))
    }

    @Test func tapClearResults() async throws {
        // Given

        // When
        await sut.process(.tapClearResults)

        // Then
        #expect(sut.state == .hidden)
    }

    @Test func textEmpty() async throws {
        // Given

        // When
        await sut.process(.searchTextChanged(""))

        // Then
        #expect(sut.state == .hidden)
    }

    @Test func nilResult() async throws {
        // Given
        searchHeroByNameUseCaseProtocolMock.invokeReturnValue = nil

        // When
        await sut.process(.searchTextChanged("A"))

        // Then
        #expect(sut.state == .hidden)
    }

    @Test func error() async throws {
        // Given
        searchHeroByNameUseCaseProtocolMock.invokeThrowableError = TestError.genericError

        // When
        await sut.process(.searchTextChanged("A"))

        // Then
        #expect(sut.state == .error)
    }

    @Test func noResults() async throws {
        // Given
        searchHeroByNameUseCaseProtocolMock.invokeReturnValue = []

        // When
        await sut.process(.searchTextChanged("A"))

        // Then
        #expect(sut.state == .noResults)
    }

    private func setDependencies() {
        container.searchHeroByNameUseCase.register { searchHeroByNameUseCaseProtocolMock }
    }

    private enum TestError: Error {
        case genericError
    }
}
