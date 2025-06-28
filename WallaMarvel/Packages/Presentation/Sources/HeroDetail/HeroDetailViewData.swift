import Domain
import DesignSystem

public struct HeroDetailViewData: Identifiable, Equatable, Sendable {
    public let id: String
    let name: String
    let image: String
    let deck: String
    let creators: [String]
    let enemies: [String]
    let friends: [String]

    public init(id: String, name: String, image: String, deck: String, creators: [String], enemies: [String], friends: [String]) {
        self.id = id
        self.name = name
        self.image = image
        self.deck = deck
        self.creators = creators
        self.enemies = enemies
        self.friends = friends
    }
}
