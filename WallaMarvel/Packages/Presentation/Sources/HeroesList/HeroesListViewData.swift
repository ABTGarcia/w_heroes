import DesignSystem
import Domain

public struct HeroesListViewData: Equatable, Sendable {
    var list: [HeroCardViewData] = []
    var isLoading: Bool = false
    var hasError: Bool = false

    public init(heroes: [Hero], isLoading: Bool, searchList _: [SearchResultsCardViewData], hasError: Bool = false) {
        list = heroes.map { heroToCard($0) }
        self.isLoading = isLoading
        self.hasError = hasError
    }

    public mutating func appendHeroes(_ heroes: [Hero]) {
        for hero in heroes {
            list.append(heroToCard(hero))
        }
    }

    private func heroToCard(_ hero: Hero) -> HeroCardViewData {
        let realName = hero.realName?.trimmingCharacters(in: .whitespaces)
        return HeroCardViewData(
            id: hero.id,
            image: hero.image,
            name: hero.name,
            realName: (realName ?? "").isEmpty ? nil : realName,
            description: hero.description,
            apiDetailUrl: hero.apiDetailUrl
        )
    }
}
