import Domain

struct HeroEntity: Codable, Equatable {
    let id: Int
    let name: String
    let realName: String?
    let deck: String?
    let image: ImageEntity

    public func toDomain() -> Hero {
        Hero(id: String(id), image: image.iconUrl, name: name, description: deck ?? "")
    }
}
