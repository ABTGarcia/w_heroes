import DesignSystem
import Domain

public struct HeroesListViewData: Equatable, Sendable {
    let list: [HeroCardViewData]

    public init(model: HeroesList) {
        list = model.heroes.map({ hero in
            HeroCardViewData(
                id: hero.id,
                image: hero.image,
                name: hero.name,
                description: hero.description)
        })
    }
}
