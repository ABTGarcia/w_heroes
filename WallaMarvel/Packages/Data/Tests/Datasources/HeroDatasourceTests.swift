import Testing
@testable import Data
import Domain
import FactoryKit

struct HeroDatasourceTests {
    private var sut: HeroDatasource
    private let container: Container
    private let networkService = NetworkServiceProtocolMock()

    init() {
        container = Container()
        sut = HeroDatasource(container: container)
        setDependencies()
    }

    @Test func findAll() async throws {
        // Given
        let list = ListEntity(
            limit: 1,
            offset: 2,
            numberOfTotalResults: 3,
            results: [
                HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "D", screenUrl: "E"))
            ])
        networkService.requestWithReturnValue = list

        // When
        let result = try await sut.findAll(from: 0)

        // Then
        #expect(networkService.requestWithCalled)
        #expect(result == list)
    }

    private func setDependencies() {
        container.networkService.register { networkService }
    }
}
