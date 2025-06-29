@testable import Data
import Testing

struct HeroesListEndpointTests {
    @Test func values() async throws {
        // Given
        let sut = HeroesListEndpoint(from: 10)

        // Then
        #expect(sut.path == "characters")
        #expect(sut.httpMethod == .get)
        #expect(sut.queryParams == [
            "limit": "20",
            "format": "json",
            "offset": "10",
            "field_list": "id,name,api_detail_url,image,real_name,deck"
        ])
    }
}
