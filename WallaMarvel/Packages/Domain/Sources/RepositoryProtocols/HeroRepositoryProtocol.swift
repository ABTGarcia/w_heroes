// sourcery: AutoMockable
public protocol HeroRepositoryProtocol: Sendable {
    func findAll(from position: Int) async throws -> HeroesList
    func getDetail(withUrl url: String) async throws -> HeroDetail
    func searchByName(_ name: String) async throws -> [Hero]
}
