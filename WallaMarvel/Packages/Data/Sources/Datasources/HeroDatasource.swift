import Domain
import FactoryKit

// sourcery: AutoMockable
protocol HeroDatasourceProtocol: Sendable {
    func findAll(from position: Int) async throws -> ListEntity<[HeroEntity]>
    func getDetail(withUrl url: String) async throws -> HeroDetailEntity
}

final class HeroDatasource: HeroDatasourceProtocol {
    private let container: Container

    public init(container: Container = .shared) {
        self.container = container
    }

    func findAll(from position: Int) async throws -> ListEntity<[HeroEntity]> {
        let response: ListEntity<[HeroEntity]> = try await container.networkService().request(
            with: HeroesListEndpoint(from: position)
        )

        return response
    }

    func getDetail(withUrl url: String) async throws -> HeroDetailEntity {
        let response: ListEntity<HeroDetailEntity> = try await container.networkService().request(
            with: HeroDetailEndpoint(detailUrl: url)
        )

        return response.results
    }
}
