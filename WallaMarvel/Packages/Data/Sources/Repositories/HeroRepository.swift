import Domain
import FactoryKit
import SwiftData

public final class HeroRepository: HeroRepositoryProtocol {
    private let container: Container
    private let limit = 20

    public init(container: Container = .shared) {
        self.container = container
    }

    public func findAll(from position: Int) async throws -> HeroesList {
        do {
            let response = try await container.heroRemoteDatasource().findAll(from: position, limit: limit)
            try await container.heroLocalDatasource().save(heroes: response.results)

            return responseToHeroesList(response)
        } catch {
            let response = try await container.heroLocalDatasource().findAll(from: position, limit: limit)

            return responseToHeroesList(response)
        }
    }

    public func getDetail(withUrl url: String) async throws -> HeroDetail {
        do {
            let response = try await container.heroRemoteDatasource().getDetail(withUrl: url)
            response.apiDetailUrl = url
            try await container.heroLocalDatasource().save(heroDetail: response)
            return response.toDomain()

        } catch {
            let response = try await container.heroLocalDatasource().getDetail(withUrl: url)
            return response.toDomain()
        }
    }

    public func searchByName(_ name: String) async throws -> [Hero] {
        do {
            let response = try await container.heroRemoteDatasource().searchByName(name)
            return response.map { $0.toDomain() }
        } catch {
            let response = try await container.heroLocalDatasource().searchByName(name)
            return response.map { $0.toDomain() }
        }
    }

    private func responseToHeroesList(_ response: ListEntity<[HeroEntity]>) -> HeroesList {
        let heroes = response.results.map { $0.toDomain() }
        let pagination = response.domainPagination()

        return HeroesList(heroes: heroes, pagination: pagination)
    }
}
