import Domain

struct HeroEntity: Codable, Equatable {
    let id: Int
    let name: String
    let realName: String?
    let deck: String?
    let image: ImageEntity
    let apiDetailUrl: String

    public func toDomain() -> Hero {
        Hero(id: String(id), image: image.smallUrl, thumbnail: image.iconUrl, name: name, realName: realName, description: deck, apiDetailUrl: apiDetailUrl)
    }
}
