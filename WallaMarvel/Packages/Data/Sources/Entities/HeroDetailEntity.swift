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
}
