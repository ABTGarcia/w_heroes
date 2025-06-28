import Testing
@testable import Data

struct HeroesListEndpointTests {
    @Test func testValues() async throws {
        // Given
        let sut = HeroesListEndpoint(from: 10)

        // Then
        #expect(sut.path == "characters")
        #expect(sut.httpMethod == .get)
        #expect(sut.queryParams == ["limit": "20", "format": "json", "offset": "10"])
    }
}
