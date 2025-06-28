// sourcery: AutoMockable
public protocol HeroRepositoryProtocol: Sendable {
    func findAll(from position: Int) async throws -> HeroesList
}
