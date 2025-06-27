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
        guard let repository = container.heroRepository() else {
            preconditionFailure("Repository not found")
        }
        return try await repository.findAll()
    }
}
