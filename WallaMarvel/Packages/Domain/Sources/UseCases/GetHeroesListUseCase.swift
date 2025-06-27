import FactoryKit

// sourcery: AutoMockable
public protocol GetHeroesListUseCaseProtocol: Sendable {
    func invoke() async throws -> HeroesList
}

public struct GetHeroesListUseCase: GetHeroesListUseCaseProtocol {
    private let container: Container

    public init(container: Container = .shared) {
        self.container = container
    }

    public func invoke() async throws -> HeroesList {
        let heroes = [Hero(id: "1", image: "AAA", name: "BBB", description: "CCC")]
        let pagination = Pagination(offset: 0, limit: 20, total: 30, count: 1)
        return HeroesList(heroes: heroes, pagination: pagination)
    }
}
