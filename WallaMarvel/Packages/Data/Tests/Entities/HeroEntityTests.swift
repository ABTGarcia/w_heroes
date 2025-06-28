@testable import Data
import Domain
import Testing

struct HeroEntityTests {
    @Test func toDomain() async throws {
        // Given
        let expected = Hero(id: "1", image: "D", name: "A", description: "C")
        let sut = HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "D", screenUrl: "E"))

        // When
        let result = sut.toDomain()

        // Then
        #expect(result == expected)
    }
}
