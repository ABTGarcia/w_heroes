import DesignSystem
import Domain

public struct HeroDetailViewData: Equatable, Sendable {
    let name: String
    let realName: String?
    let image: String
    let deck: String?
    let creators: [String]
    let enemies: [String]
    let friends: [String]

    public init(name: String, realName: String?, image: String, deck: String?, creators: [String], enemies: [String], friends: [String]) {
        let realName = realName?.trimmingCharacters(in: .whitespaces)
        let deck = deck?.trimmingCharacters(in: .whitespaces)

        self.name = name
        self.realName = (realName ?? "").isEmpty ? nil : realName
        self.image = image
        self.deck = (deck ?? "").isEmpty ? nil : deck
        self.creators = creators
        self.enemies = enemies
        self.friends = friends
    }
}
