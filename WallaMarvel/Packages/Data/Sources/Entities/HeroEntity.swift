import Domain
import SwiftData

@Model
class HeroEntity: Codable, Equatable {
    var id: Int
    var name: String
    var realName: String?
    var deck: String?
    var image: ImageEntity
    var apiDetailUrl: String

    init(id: Int, name: String, realName: String? = nil, deck: String? = nil, image: ImageEntity, apiDetailUrl: String) {
        self.id = id
        self.name = name
        self.realName = realName
        self.deck = deck
        self.image = image
        self.apiDetailUrl = apiDetailUrl
    }

    enum CodingKeys: CodingKey {
        case id, name, realName, deck, image, apiDetailUrl
    }

    public func toDomain() -> Hero {
        Hero(id: String(id), image: image.smallUrl, thumbnail: image.iconUrl, name: name, realName: realName, description: deck, apiDetailUrl: apiDetailUrl)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        realName = try container.decodeIfPresent(String.self, forKey: .realName)
        deck = try container.decodeIfPresent(String.self, forKey: .deck)
        image = try container.decode(ImageEntity.self, forKey: .image)
        apiDetailUrl = try container.decode(String.self, forKey: .apiDetailUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(realName, forKey: .realName)
        try container.encode(deck, forKey: .deck)
        try container.encode(image, forKey: .image)
        try container.encode(apiDetailUrl, forKey: .apiDetailUrl)
    }
}
