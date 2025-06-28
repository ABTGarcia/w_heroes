import FactoryKit

// sourcery: AutoMockable
public protocol GetHeroesListUseCaseProtocol: Sendable {
    mutating func invoke(lastId: String?) async throws -> HeroesList
}

public struct GetHeroesListUseCase: GetHeroesListUseCaseProtocol {
    private let container: Container
    private var pagination = Pagination(offset: 0, limit: 0, total: 1)
    private var heroes: [Hero] = []
    private var canRequestMore = true

    public init(container: Container = .shared) {
        self.container = container
    }

    public mutating func invoke(lastId: String?) async throws -> HeroesList {
        guard let repository = container.heroRepository() else {
            preconditionFailure("Repository not found")
        }
        guard canRequestMore, heroes.count < pagination.total else {
            return HeroesList(heroes: [], pagination: pagination)
        }

        if heroes.isEmpty || heroes.suffix(5).contains(where: { $0.id == lastId}) {
            canRequestMore = false
            let offset = pagination.offset + pagination.limit

            let list = try await repository.findAll(from: offset)

            pagination = list.pagination
            heroes.append(contentsOf: list.heroes)

            canRequestMore = true
            return list
        } else {
            return HeroesList(heroes: [], pagination: pagination)
        }

    }
}
