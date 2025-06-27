// sourcery: AutoMockable
public protocol HeroRepositoryProtocol: Sendable {
    func findAll() async throws -> HeroesList
}
