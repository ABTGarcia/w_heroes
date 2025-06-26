public struct HeroesListViewData: Equatable, Sendable {
    let list: [HeroeViewData]
}

public struct HeroeViewData: Equatable, Sendable, Identifiable {
    public let id: String
    let image: String
    let name: String
}
