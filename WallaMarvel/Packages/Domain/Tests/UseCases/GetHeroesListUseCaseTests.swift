import Testing
@testable import Domain
import FactoryKit

struct GetHeroesListUseCaseTests {
    private let sut: GetHeroesListUseCase
    private let heroRepository = HeroRepositoryProtocolMock()
    private let container: Container

    private let heroesList = HeroesList(
        heroes: [
            Hero(id: "1", image: "AAA", name: "BBB", description: "CCC")
        ],
        pagination: Pagination(offset: 0, limit: 20, total: 30)
    )

    init() {
        container = Container()
        sut = GetHeroesListUseCase(container: container)
        setDependencies()
    }

    @Test func invoke() async throws {
        // Given
        heroRepository.findAllReturnValue = heroesList

        // When
        let result = try await sut.invoke()

        // Then
        #expect(heroRepository.findAllCallsCount == 1)
        #expect(result == heroesList)
    }

    private func setDependencies() {
        container.heroRepository.register { heroRepository }
    }
}
