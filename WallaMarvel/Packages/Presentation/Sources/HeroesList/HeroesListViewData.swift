import DesignSystem
import Domain

public struct HeroesListViewData: Equatable, Sendable {
    var list: [HeroCardViewData] = []
    var isLoading: Bool = false

    public init(heroes: [Hero], isLoading: Bool) {
        list = heroes.map { heroToCard($0) }
        self.isLoading = isLoading
    }

    public mutating func appendHeroes(_ heroes: [Hero]) {
        for hero in heroes {
            list.append(heroToCard(hero))
        }
    }

    private func heroToCard(_ hero: Hero) -> HeroCardViewData {
        HeroCardViewData(
            id: hero.id,
            image: hero.image,
            name: hero.name,
            realName: hero.realName,
            description: hero.description,
            apiDetailUrl: hero.apiDetailUrl
        )
    }
}
