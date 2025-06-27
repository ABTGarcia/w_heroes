import Testing
@testable import Domain
import FactoryKit

struct GetHeroesListUseCaseTests {
    private var sut: GetHeroesListUseCase
    private let container: Container

    private let heroesList = HeroesList(
        heroes: [
            Hero(id: "1", image: "AAA", name: "BBB", description: "CCC")
        ],
        pagination: Pagination(offset: 0, limit: 20, total: 30, count: 1)
    )

    init() {
        container = Container()
        sut = GetHeroesListUseCase(container: container)
    }

    @Test func invoke() async throws {
        // When
        let result = try await sut.invoke()

        // Then
        #expect(result == heroesList)
    }
}
