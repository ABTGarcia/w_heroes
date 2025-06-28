@testable import Data
import Testing

struct NetworkEndpointTests {
    @Test func defaultData() async throws {
        // Given
        let sut = NetworkEndpointMock()

        // Then
        #expect(sut.path == "test")
        #expect(sut.baseURL == "https://comicvine.gamespot.com/api/")
        #expect(sut.cachePolicy == .useProtocolCachePolicy)
        #expect(sut.httpBody == .none)
        #expect(sut.httpMethod == .get)
        #expect(sut.queryParams == ["format": "json"])
        #expect(sut.headers == .none)
        #expect(sut.timeoutInterval == 10.0)
    }

    struct NetworkEndpointMock: NetworkEndpointProtocol {
        var path = "test"
    }
}
