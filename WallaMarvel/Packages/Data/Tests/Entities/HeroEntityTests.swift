@testable import Data
import Domain
import Testing

struct HeroEntityTests {
    @Test func toDomain() async throws {
        // Given
        let expected = Hero(id: "1", image: "D", thumbnail: "D", name: "A", realName: "FDF", description: "C", apiDetailUrl: "J")
        let sut = HeroEntity(id: 1, name: "A", realName: "FDF", deck: "C", image: ImageEntity(iconUrl: "D", smallUrl: "D", screenUrl: "E"), apiDetailUrl: "J")

        // When
        let result = sut.toDomain()

        // Then
        #expect(result == expected)
    }
}
