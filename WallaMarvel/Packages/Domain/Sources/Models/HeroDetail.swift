public struct HeroDetail: Equatable, Sendable {
    public let name: String
    public let realName: String?
    public let deck: String?
    public let image: String
    public let creators: [String]
    public let friends: [String]
    public let enemies: [String]

    public init(name: String, realName: String? = nil, deck: String? = nil, image: String, creators: [String], friends: [String], enemies: [String]) {
        self.name = name
        self.realName = realName
        self.deck = deck
        self.image = image
        self.creators = creators
        self.friends = friends
        self.enemies = enemies
    }
}
