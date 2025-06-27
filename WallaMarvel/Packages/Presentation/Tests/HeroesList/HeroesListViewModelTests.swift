import Testing
@testable import Presentation
import FactoryKit
import TestExtensions
import DesignSystem
import Domain

@MainActor
struct HeroesListViewModelTests {
    private var sut: HeroesListViewModel!
    private let container: Container
    private var getHeroesListUseCaseProtocolMock = GetHeroesListUseCaseProtocolMock()

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
        let heroesList = HeroesList(
            heroes: [Hero(id: "1", image: "A", name: "B", description: "C")],
            pagination: Pagination(offset: 1, limit: 2, total: 3))
        let listData = HeroesListViewData(model: heroesList)
        getHeroesListUseCaseProtocolMock.invokeReturnValue = heroesList

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == .loaded(listData))
        #expect(getHeroesListUseCaseProtocolMock.invokeCallsCount == 1)
    }

    @Test func loadDataUseCaseNil() async throws {
        // Given
        container.getHeroesListUseCase.register { nil }

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == .error)
    }

    @Test func loadDataThrows() async throws {
        // Given
        getHeroesListUseCaseProtocolMock.invokeThrowableError = TestError.genericError

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == .error)
    }

    private func setDependencies() {
        container.getHeroesListUseCase.register { getHeroesListUseCaseProtocolMock }
    }

    private enum TestError: Error {
        case genericError
    }
}
