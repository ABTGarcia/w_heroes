import Testing
@testable import Data
import Domain
import FactoryKit

struct HeroRepositoryTests {
    private var sut: HeroRepository
    private let container: Container
    private var heroDatasource = HeroDatasourceProtocolMock()
    private var responseList: ListEntity<[HeroEntity]> {
        ListEntity(
            limit: 1,
            offset: 2,
            numberOfTotalResults: 3,
            results: [
                HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "D", screenUrl: "E"))
            ])
    }

    init() {
        container = Container()
        sut = HeroRepository(container: container)
        setDependencies()
    }

    @Test func findAll() async throws {
        // Given
        let heroesDomain = responseList.results.map { $0.toDomain() }
        let paginationDomain = responseList.domainPagination()
        heroDatasource.findAllReturnValue = responseList

        // When
        let result = try await sut.findAll()

        // Then
        #expect(heroDatasource.findAllCallsCount == 1)
        #expect(result == HeroesList(heroes: heroesDomain, pagination: paginationDomain))
    }

    private func setDependencies() {
        container.heroDatasource.register { heroDatasource }
    }
}
