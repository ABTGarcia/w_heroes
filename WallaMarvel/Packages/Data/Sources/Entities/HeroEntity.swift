import Domain

struct HeroEntity: Codable, Equatable {
    let id: Int
    let name: String
    let realName: String?
    let deck: String?
    let image: ImageEntity

    public func toDomain() -> Hero {
        Hero(id: String(self.id), image: self.image.iconUrl, name: self.name, description: self.deck ?? "")
    }
}
