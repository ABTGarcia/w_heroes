@testable import Data
import Testing

struct HeroDetailEndpointTests {
    @Test func values() async throws {
        // Given
        let detailUrl = "AAA"
        let sut = HeroDetailEndpoint(detailUrl: detailUrl)

        // Then
        #expect(sut.path == "")
        #expect(sut.httpMethod == .get)
        #expect(sut.baseURL == detailUrl)
        #expect(sut.queryParams == [
            "format": "json",
            "field_list": "id,name,real_name,image,creators,deck,character_friends,character_enemies"
        ])
    }
}
