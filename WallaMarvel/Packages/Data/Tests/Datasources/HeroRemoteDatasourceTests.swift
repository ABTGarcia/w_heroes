@testable import Data
import Domain
import FactoryKit
import Testing

struct HeroRemoteDatasourceTests {
    private var sut: HeroRemoteDatasource
    private let container: Container
    private let networkService = NetworkServiceProtocolMock()

    init() {
        container = Container()
        sut = HeroRemoteDatasource(container: container)
        setDependencies()
    }

    @Test func findAll() async throws {
        // Given
        let list = ListEntity(
            limit: 1,
            offset: 2,
            numberOfTotalResults: 3,
            results: [
                HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "A", smallUrl: "D", screenUrl: "E"), apiDetailUrl: "J")
            ]
        )
        networkService.requestWithReturnValue = list

        // When
        let result = try await sut.findAll(from: 0, limit: 20)

        // Then
        #expect(networkService.requestWithCalled)
        #expect(result == list)
    }

    @Test func getDetail() async throws {
        // Given
        let detailUrl = "AAA"
        let list = ListEntity(
            limit: 1,
            offset: 2,
            numberOfTotalResults: 3,
            results:
            HeroDetailEntity(
                id: 1,
                name: "A",
                realName: "B",
                deck: "C",
                image: ImageEntity(iconUrl: "A", smallUrl: "D", screenUrl: "E"),
                creators: [RelatedSource(id: 2, name: "F", apiDetailUrl: "G", hero: nil)],
                characterFriends: [RelatedSource(id: 3, name: "H", apiDetailUrl: "I", hero: nil)],
                characterEnemies: [RelatedSource(id: 4, name: "J", apiDetailUrl: "K", hero: nil)]
            )
        )
        networkService.requestWithReturnValue = list

        // When
        let result = try await sut.getDetail(withUrl: detailUrl)

        // Then
        #expect(networkService.requestWithCalled)
        #expect(result == list.results)
    }

    @Test func searchByName() async throws {
        // Given
        let list = ListEntity(
            limit: 1,
            offset: 2,
            numberOfTotalResults: 3,
            results: [
                HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "A", smallUrl: "D", screenUrl: "E"), apiDetailUrl: "J")
            ]
        )
        networkService.requestWithReturnValue = list

        // When
        let result = try await sut.searchByName("A")

        // Then
        #expect(networkService.requestWithCalled)
        #expect(result == list.results)
    }

    private func setDependencies() {
        container.networkService.register { networkService }
    }
}
