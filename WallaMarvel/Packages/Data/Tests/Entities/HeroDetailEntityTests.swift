@testable import Data
import Domain
import Testing

struct HeroDetailEntityTests {
    @Test func toDomain() async throws {
        // Given
        let expected = HeroDetail(name: "A", realName: "B", deck: "C", image: "E", creators: ["F"], friends: ["H"], enemies: ["J"])
        let sut = HeroDetailEntity(
            id: 1,
            name: "A",
            realName: "B",
            deck: "C",
            image: ImageEntity(iconUrl: "A", smallUrl: "D", screenUrl: "E"),
            creators: [RelatedSource(id: 2, name: "F", apiDetailUrl: "G", hero: nil), RelatedSource(id: 3, name: "F", apiDetailUrl: "Z", hero: nil)],
            characterFriends: [RelatedSource(id: 3, name: "H", apiDetailUrl: "I", hero: nil), RelatedSource(id: 4, name: "H", apiDetailUrl: "T", hero: nil)],
            characterEnemies: [RelatedSource(id: 4, name: "J", apiDetailUrl: "K", hero: nil), RelatedSource(id: 5, name: "J", apiDetailUrl: "Q", hero: nil)]
        )

        // When
        let result = sut.toDomain()

        // Then
        #expect(result == expected)
    }
}
