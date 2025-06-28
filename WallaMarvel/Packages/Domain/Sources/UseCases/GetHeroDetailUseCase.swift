import FactoryKit

// sourcery: AutoMockable
public protocol GetHeroDetailUseCaseProtocol: Sendable {
    mutating func invoke(detailUrl: String) async throws -> HeroDetail
}

public struct GetHeroDetailUseCase: GetHeroDetailUseCaseProtocol {
    private let container: Container

    public init(container: Container = .shared) {
        self.container = container
    }

    public mutating func invoke(detailUrl: String) async throws -> HeroDetail {
        guard let repository = container.heroRepository() else {
            preconditionFailure("Repository not found")
        }

        return try await repository.getDetail(withUrl: detailUrl)
    }
}
