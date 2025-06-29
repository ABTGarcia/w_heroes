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
            creators: [RelatedSource(id: 2, name: "F", apiDetailUrl: "G"), RelatedSource(id: 3, name: "F", apiDetailUrl: "Z")],
            characterFriends: [RelatedSource(id: 3, name: "H", apiDetailUrl: "I"), RelatedSource(id: 4, name: "H", apiDetailUrl: "T")],
            characterEnemies: [RelatedSource(id: 4, name: "J", apiDetailUrl: "K"), RelatedSource(id: 5, name: "J", apiDetailUrl: "Q")]
        )

        // When
        let result = sut.toDomain()

        // Then
        #expect(result == expected)
    }
}
