import Domain
import SwiftData

@Model
class HeroDetailEntity: Codable, Equatable {
    @Relationship(deleteRule: .cascade, inverse: \RelatedSource.hero)
    var id: Int
    var name: String
    var realName: String?
    var deck: String?
    var image: ImageEntity
    var creators: [RelatedSource]
    var characterFriends: [RelatedSource]
    var characterEnemies: [RelatedSource]
    var apiDetailUrl: String?

    init(
        id: Int,
        name: String,
        realName: String? = nil,
        deck: String? = nil,
        image: ImageEntity,
        creators: [RelatedSource],
        characterFriends: [RelatedSource],
        characterEnemies: [RelatedSource],
        apiDetailUrl: String? = nil
    ) {
        self.id = id
        self.name = name
        self.realName = realName
        self.deck = deck
        self.image = image
        self.creators = creators
        self.characterFriends = characterFriends
        self.characterEnemies = characterEnemies
        self.apiDetailUrl = apiDetailUrl
    }

    enum CodingKeys: CodingKey {
        case id, name, realName, deck, image, creators, characterFriends, characterEnemies, apiDetailUrl
    }

    public func toDomain() -> HeroDetail {
        HeroDetail(
            name: name,
            realName: realName,
            deck: deck,
            image: image.screenUrl,
            creators: relatedNamesWithoutDuplicates(creators),
            friends: relatedNamesWithoutDuplicates(characterFriends),
            enemies: relatedNamesWithoutDuplicates(characterEnemies)
        )
    }

    private func relatedNamesWithoutDuplicates(_ source: [RelatedSource]) -> [String] {
        let creators = source.compactMap(\.name)
        return creators.reduce(into: [String]()) { result, name in
            if !result.contains(name) {
                result.append(name)
            }
        }
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        realName = try container.decodeIfPresent(String.self, forKey: .realName)
        deck = try container.decodeIfPresent(String.self, forKey: .deck)
        image = try container.decode(ImageEntity.self, forKey: .image)
        creators = try container.decode([RelatedSource].self, forKey: .creators)
        characterFriends = try container.decode([RelatedSource].self, forKey: .characterFriends)
        characterEnemies = try container.decode([RelatedSource].self, forKey: .characterEnemies)
        apiDetailUrl = try container.decodeIfPresent(String.self, forKey: .apiDetailUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(realName, forKey: .realName)
        try container.encode(deck, forKey: .deck)
        try container.encode(image, forKey: .image)
        try container.encode(creators, forKey: .creators)
        try container.encode(characterFriends, forKey: .characterFriends)
        try container.encode(characterEnemies, forKey: .characterEnemies)
        try container.encode(apiDetailUrl, forKey: .apiDetailUrl)
    }
}
