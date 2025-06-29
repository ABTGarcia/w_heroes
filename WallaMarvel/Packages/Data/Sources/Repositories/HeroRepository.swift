import Domain
import FactoryKit

public final class HeroRepository: HeroRepositoryProtocol {
    private let container: Container

    public init(container: Container = .shared) {
        self.container = container
    }

    public func findAll(from position: Int) async throws -> HeroesList {
        let response = try await container.heroDatasource().findAll(from: position)

        let heroes = response.results.map { $0.toDomain() }
        let pagination = response.domainPagination()

        return HeroesList(heroes: heroes, pagination: pagination)
    }

    public func getDetail(withUrl url: String) async throws -> HeroDetail {
        let response = try await container.heroDatasource().getDetail(withUrl: url)

        return response.toDomain()
    }

    public func searchByName(_ name: String) async throws -> [Hero] {
        let response = try await container.heroDatasource().searchByName(name)
        return response.map { $0.toDomain() }
    }
}
