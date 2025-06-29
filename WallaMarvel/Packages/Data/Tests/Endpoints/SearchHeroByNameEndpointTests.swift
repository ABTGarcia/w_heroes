@testable import Data
import Testing

struct SearchHeroByNameEndpointTests {
    @Test func values() async throws {
        // Given
        let sut = SearchHeroByNameEndpoint("AAA")

        // Then
        #expect(sut.path == "search")
        #expect(sut.httpMethod == .get)
        #expect(sut.queryParams == [
            "limit": "100",
            "format": "json",
            "query": "name:AAA",
            "resources": "character",
            "field_list": "id,name,api_detail_url,image,real_name,deck"
        ])
    }
}
