import Domain

struct HeroDetailEntity: Codable, Equatable {
    let id: Int
    let name: String
    let realName: String?
    let deck: String?
    let image: ImageEntity
    let creators: [RelatedSource]
    let characterFriends: [RelatedSource]
    let characterEnemies: [RelatedSource]

    public func toDomain() -> HeroDetail {
        HeroDetail(
            name: name,
            realName: realName,
            deck: deck,
            image: image.screenUrl,
            creators: creators.compactMap(\.name),
            friends: characterFriends.compactMap(\.name),
            enemies: characterEnemies.compactMap(\.name)
        )
    }
}
