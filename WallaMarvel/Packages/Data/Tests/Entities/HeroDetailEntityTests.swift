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
            image: ImageEntity(smallUrl: "D", screenUrl: "E"),
            creators: [RelatedSource(id: 2, name: "F", apiDetailUrl: "G")],
            characterFriends: [RelatedSource(id: 3, name: "H", apiDetailUrl: "I")],
            characterEnemies: [RelatedSource(id: 4, name: "J", apiDetailUrl: "K")]
        )

        // When
        let result = sut.toDomain()

        // Then
        #expect(result == expected)
    }
}
