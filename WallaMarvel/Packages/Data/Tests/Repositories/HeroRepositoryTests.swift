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
                HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "F", smallUrl: "D", screenUrl: "E"), apiDetailUrl: "J")
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

    @Test func getDetail() async throws {
        // Given
        let detailURL = "AAA"
        let detailEntity = HeroDetailEntity(
            id: 1,
            name: "A",
            realName: "B",
            deck: "C",
            image: ImageEntity(iconUrl: "F", smallUrl: "D", screenUrl: "E"),
            creators: [RelatedSource(id: 1, name: "F", apiDetailUrl: "G")],
            characterFriends: [RelatedSource(id: 2, name: "H", apiDetailUrl: "I")],
            characterEnemies: [RelatedSource(id: 3, name: "J", apiDetailUrl: "K")]
        )
        heroDatasource.getDetailWithUrlReturnValue = detailEntity

        // When
        let result = try await sut.getDetail(withUrl: detailURL)

        // Then
        #expect(heroDatasource.getDetailWithUrlCallsCount == 1)
        #expect(heroDatasource.getDetailWithUrlReceivedUrl == detailURL)
        #expect(result == detailEntity.toDomain())
    }

    @Test func searchByName() async throws {
        // Given
        let name = "AAA"
        let returnValue = [HeroEntity(
            id: 1,
            name: "A",
            realName: "B",
            deck: "C",
            image: ImageEntity(iconUrl: "F", smallUrl: "D", screenUrl: "E"),
            apiDetailUrl: "J"
        )]
        heroDatasource.searchByNameReturnValue = returnValue

        // When
        let result = try await sut.searchByName(name)

        // Then
        #expect(heroDatasource.searchByNameCallsCount == 1)
        #expect(heroDatasource.searchByNameReceivedName == name)
        #expect(result == returnValue.map { $0.toDomain() })
    }

    private func setDependencies() {
        container.heroDatasource.register { heroDatasource }
    }
}
