import Testing
@testable import Data

struct HeroesListEndpointTests {
    @Test func testValues() async throws {
        // Given
        let sut = HeroesListEndpoint()

        // Then
        #expect(sut.path == "characters")
        #expect(sut.httpMethod == .get)
    }
}
