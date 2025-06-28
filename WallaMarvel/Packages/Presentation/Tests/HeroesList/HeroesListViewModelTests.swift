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
    private let heroesList = HeroesList(
        heroes: [Hero(id: "1", image: "A", name: "B", description: "C")],
        pagination: Pagination(offset: 1, limit: 2, total: 5)
    )

    init() {
        container = Container()
        setDependencies()
        sut = HeroesListViewModel(container: container)
    }

    @Test func initTests() async throws {
        // Then
        #expect(sut.state == .loading)
    }

    @Test func loadData() async throws {
        // Given
        let expected: HeroesListState = .loaded(HeroesListViewData(heroes: heroesList.heroes, isLoading: false))
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == expected)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == nil)
    }

    @Test func loadDataLastHeroReached() async throws {
        // Given
        let heroesList = HeroesList(
            heroes: [Hero(id: "1", image: "A", name: "B", description: "C")],
            pagination: Pagination(offset: 10, limit: 20, total: 3)
        )
        let expected: HeroesListState = .loaded(HeroesListViewData(heroes: [], isLoading: false))
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == expected)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == nil)
    }

    @Test func loadDataLoadingMore() async throws {
        // Given
        let heroesList = HeroesList(
            heroes: [],
            pagination: Pagination(offset: 1, limit: 2, total: 5)
        )
        let expected: HeroesListState = .loaded(HeroesListViewData(heroes: [], isLoading: true))
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == expected)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == nil)
    }

    @Test func loadDataThrows() async throws {
        // Given
        getHeroesListUseCaseProtocolMock.invokeLastIdThrowableError = TestError.genericError

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == .error)
    }

    @Test func appearedHeroId() async throws {
        // Given
        let listData = HeroesListViewData(heroes: heroesList.heroes, isLoading: false)
        getHeroesListUseCaseProtocolMock.invokeLastIdReturnValue = heroesList

        // When
        await sut.process(.appearedHeroId("5"))

        // Then
        #expect(sut.state == .loaded(listData))
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdCallsCount == 1)
        #expect(getHeroesListUseCaseProtocolMock.invokeLastIdReceivedLastId == "5")
    }

    private func setDependencies() {
        container.getHeroesListUseCase.register { getHeroesListUseCaseProtocolMock }
    }

    private enum TestError: Error {
        case genericError
    }
}
