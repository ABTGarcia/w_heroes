public struct HeroesList: Equatable, Sendable {
    public let heroes: [Hero]
    public let pagination: Pagination

    public init(heroes: [Hero], pagination: Pagination) {
        self.heroes = heroes
        self.pagination = pagination
    }
}
