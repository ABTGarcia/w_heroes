@testable import Data
import Domain
import FactoryKit
import Testing

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
                HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "D", screenUrl: "E"), apiDetailUrl: "J")
            ]
        )
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
        heroDatasource.findAllFromReturnValue = responseList

        // When
        let result = try await sut.findAll(from: 100)

        // Then
        #expect(heroDatasource.findAllFromCallsCount == 1)
        #expect(heroDatasource.findAllFromReceivedPosition == 100)
        #expect(result == HeroesList(heroes: heroesDomain, pagination: paginationDomain))
    }

    private func setDependencies() {
        container.heroDatasource.register { heroDatasource }
    }
}
