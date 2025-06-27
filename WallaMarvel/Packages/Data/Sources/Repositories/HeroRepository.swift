import FactoryKit
import Domain

public final class HeroRepository: HeroRepositoryProtocol {
    private let container: Container

    public init(container: Container = .shared) {
        self.container = container
    }

    public func findAll() async throws -> HeroesList {
        let response = try await container.heroDatasource().findAll()

        let heroes = response.results.map { $0.toDomain() }
        let pagination = response.domainPagination()

        return HeroesList(heroes: heroes, pagination: pagination)
    }
}
