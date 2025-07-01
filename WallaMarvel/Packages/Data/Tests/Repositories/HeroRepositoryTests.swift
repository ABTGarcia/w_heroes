@testable import Data
import Domain
import FactoryKit
import Testing

struct HeroRepositoryTests: @unchecked Sendable {
    private var sut: HeroRepository
    private let container: Container
    private var heroRemoteDatasource = HeroRemoteDatasourceProtocolMock()
    private var heroLocalDatasource = HeroLocalDatasourceProtocolMock()
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

    private let detailEntity = HeroDetailEntity(
        id: 1,
        name: "A",
        realName: "B",
        deck: "C",
        image: ImageEntity(iconUrl: "F", smallUrl: "D", screenUrl: "E"),
        creators: [RelatedSource(id: 1, name: "F", apiDetailUrl: "G")],
        characterFriends: [RelatedSource(id: 2, name: "H", apiDetailUrl: "I")],
        characterEnemies: [RelatedSource(id: 3, name: "J", apiDetailUrl: "K")]
    )

    init() {
        container = Container()
        sut = HeroRepository(container: container)
        setDependencies()
    }

    @Test func findAll() async throws {
        // Given
        let heroesDomain = responseList.results.map { $0.toDomain() }
        let paginationDomain = responseList.domainPagination()
        heroRemoteDatasource.findAllFromLimitReturnValue = responseList

        // When
        let result = try await sut.findAll(from: 100)

        // Then
        #expect(heroRemoteDatasource.findAllFromLimitCallsCount == 1)
        #expect(heroRemoteDatasource.findAllFromLimitReceivedArguments?.position == 100)
        #expect(heroRemoteDatasource.findAllFromLimitReceivedArguments?.limit == 20)
        #expect(result == HeroesList(heroes: heroesDomain, pagination: paginationDomain))
    }

    @Test func findAllLocally() async throws {
        // Given
        let heroesDomain = responseList.results.map { $0.toDomain() }
        let paginationDomain = responseList.domainPagination()
        heroRemoteDatasource.findAllFromLimitThrowableError = TestError.genericError
        heroLocalDatasource.findAllFromLimitReturnValue = responseList

        // When
        let result = try await sut.findAll(from: 100)

        // Then
        #expect(heroRemoteDatasource.findAllFromLimitCallsCount == 1)
        #expect(heroLocalDatasource.findAllFromLimitCallsCount == 1)
        #expect(heroLocalDatasource.findAllFromLimitReceivedArguments?.position == 100)
        #expect(heroLocalDatasource.findAllFromLimitReceivedArguments?.limit == 20)
        #expect(result == HeroesList(heroes: heroesDomain, pagination: paginationDomain))
    }

    @Test func getDetail() async throws {
        // Given
        let detailURL = "AAA"
        heroRemoteDatasource.getDetailWithUrlReturnValue = detailEntity

        // When
        let result = try await sut.getDetail(withUrl: detailURL)

        // Then
        #expect(heroRemoteDatasource.getDetailWithUrlCallsCount == 1)
        #expect(heroRemoteDatasource.getDetailWithUrlReceivedUrl == detailURL)
        #expect(result == detailEntity.toDomain())
    }

    @Test func getDetailLocally() async throws {
        // Given
        let detailURL = "AAA"

        heroRemoteDatasource.getDetailWithUrlThrowableError = TestError.genericError
        heroLocalDatasource.getDetailWithUrlReturnValue = detailEntity

        // When
        let result = try await sut.getDetail(withUrl: detailURL)

        // Then
        #expect(heroRemoteDatasource.getDetailWithUrlCallsCount == 1)
        #expect(heroLocalDatasource.getDetailWithUrlCallsCount == 1)
        #expect(heroRemoteDatasource.getDetailWithUrlReceivedUrl == detailURL)
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
        heroRemoteDatasource.searchByNameReturnValue = returnValue

        // When
        let result = try await sut.searchByName(name)

        // Then
        #expect(heroRemoteDatasource.searchByNameCallsCount == 1)
        #expect(heroRemoteDatasource.searchByNameReceivedName == name)
        #expect(result == returnValue.map { $0.toDomain() })
    }

    @Test func searchByNameLocally() async throws {
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
        heroRemoteDatasource.searchByNameThrowableError = TestError.genericError
        heroLocalDatasource.searchByNameReturnValue = returnValue

        // When
        let result = try await sut.searchByName(name)

        // Then
        #expect(heroRemoteDatasource.searchByNameCallsCount == 1)
        #expect(heroLocalDatasource.searchByNameCallsCount == 1)
        #expect(heroRemoteDatasource.searchByNameReceivedName == name)
        #expect(result == returnValue.map { $0.toDomain() })
    }

    private func setDependencies() {
        container.heroRemoteDatasource.register { heroRemoteDatasource }
        container.heroLocalDatasource.register { heroLocalDatasource }
    }

    private enum TestError: Error {
        case genericError
    }
}
