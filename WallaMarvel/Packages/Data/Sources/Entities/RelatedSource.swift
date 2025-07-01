import SwiftData

@Model
class RelatedSource: Codable, Equatable {
    @Relationship(inverse: \HeroDetailEntity.characterEnemies)
    @Relationship(inverse: \HeroDetailEntity.characterFriends)
    @Relationship(inverse: \HeroDetailEntity.creators)
    var id: Int
    var name: String
    var apiDetailUrl: String
    var hero: HeroDetailEntity?

    init(id: Int, name: String, apiDetailUrl: String, hero: HeroDetailEntity?) {
        self.id = id
        self.name = name
        self.apiDetailUrl = apiDetailUrl
        self.hero = hero
    }

    enum CodingKeys: CodingKey {
        case id, name, apiDetailUrl, hero
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        apiDetailUrl = try container.decode(String.self, forKey: .apiDetailUrl)
        hero = try container.decodeIfPresent(HeroDetailEntity.self, forKey: .hero)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(apiDetailUrl, forKey: .apiDetailUrl)
        try container.encode(hero, forKey: .hero)
    }
}
