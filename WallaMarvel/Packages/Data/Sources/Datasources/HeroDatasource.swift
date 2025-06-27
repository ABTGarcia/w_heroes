import FactoryKit
import Domain

// sourcery: AutoMockable
protocol HeroDatasourceProtocol: Sendable {
    func findAll() async throws -> ListEntity<[HeroEntity]>
}

final class HeroDatasource: HeroDatasourceProtocol {
    private let container: Container

    public init(container: Container = .shared) {
        self.container = container
    }

    func findAll() async throws -> ListEntity<[HeroEntity]> {
        let response: ListEntity<[HeroEntity]> = try await container.networkService().request(
            with: HeroesListEndpoint()
        )

        return response
    }
}
