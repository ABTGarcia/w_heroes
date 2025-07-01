import DesignSystem
import Domain
import FactoryKit
@testable import Presentation
import TestExtensions
import Testing

@MainActor
struct HeroesListViewModelTests {
    private var sut: HeroesListViewModel!
    private let container: Container
    private var getHeroesListUseCaseProtocolMock = GetHeroesListUseCaseProtocolMock()
    private var searchHeroByNameUseCaseProtocolMock = SearchHeroByNameUseCaseProtocolMock()
    private var coordinatorProtocolMock = CoordinatorProtocolMock()

    private let heroesList = HeroesList(
        heroes: [Hero(id: "1", image: "A", thumbnail: "F", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")],
        pagination: Pagination(offset: 1, limit: 2, total: 5)
    )

    init() {
        container = Container()
        setDependencies()
        sut = HeroesListViewModel(coordinator: coordinatorProtocolMock, container: container)
    }

    @Test func initTests() async throws {
        // Then
        #expect(sut.state == .loading)
    }

    @Test func appeared() async throws {
        // Given
        let expected: HeroesListState = .loaded(HeroesListViewData(heroes: heroesList.heroes, isLoading: false, searchList: []))
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.appeared)

        // Then
        #expect(sut.state == expected)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == nil)
    }

    @Test func appearedLastHeroReached() async throws {
        // Given
        let heroesList = HeroesList(
            heroes: [Hero(id: "1", image: "A", thumbnail: "F", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")],
            pagination: Pagination(offset: 10, limit: 20, total: 3)
        )
        let expected: HeroesListState = .loaded(HeroesListViewData(heroes: [], isLoading: false, searchList: []))
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.appeared)

        // Then
        #expect(sut.state == expected)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == nil)
    }

    @Test func appearedHeroIdLoadingMore() async throws {
        // Given
        let heroesList = HeroesList(
            heroes: [],
            pagination: Pagination(offset: 1, limit: 2, total: 5)
        )
        let expected: HeroesListState = .loaded(HeroesListViewData(heroes: [], isLoading: true, searchList: []))
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.appearedHeroId("5"))

        // Then
        #expect(sut.state == expected)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == "5")
    }

    @Test func appearedThrows() async throws {
        // Given
        getHeroesListUseCaseProtocolMock.invokeLastIdThrowableError = TestError.genericError

        // When
        await sut.process(.appeared)

        // Then
        #expect(sut.state == .error)
    }

    @Test func appearedHeroId() async throws {
        // Given
        let listData = HeroesListViewData(heroes: heroesList.heroes, isLoading: false, searchList: [])
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.appearedHeroId("5"))

        // Then
        #expect(sut.state == .loaded(listData))
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == "5")
    }

    @Test func tapMainRetry() async throws {
        // Given
        let expected: HeroesListState = .loaded(HeroesListViewData(heroes: heroesList.heroes, isLoading: false, searchList: []))
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.tapMainRetry)

        // Then
        #expect(sut.state == expected)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == nil)
    }

    @Test func tapListRetry() async throws {
        // Given
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.appeared)
        await sut.process(.tapListRetry)

        // Then
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 2)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == "1")
    }

    @Test func tapHeroCell() async throws {
        // Given
        let url = "AA"

        // When
        await sut.process(.tapHeroCell(url))

        // Then
        #expect(coordinatorProtocolMock.pushPageReceivedPage == .heroDetail(url))
    }

    @Test func tapHeroCellEmptyUrlDoesntNavigates() async throws {
        // Given
        let url = ""

        // When
        await sut.process(.tapHeroCell(url))

        // Then
        #expect(!coordinatorProtocolMock.pushPageCalled)
    }

    private func setDependencies() {
        container.getHeroesListUseCase.register { getHeroesListUseCaseProtocolMock }
        container.searchHeroByNameUseCase.register { searchHeroByNameUseCaseProtocolMock }
    }

    private enum TestError: Error {
        case genericError
    }
}
