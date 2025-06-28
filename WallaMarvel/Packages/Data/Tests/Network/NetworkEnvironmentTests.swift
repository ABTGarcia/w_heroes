@testable import Data
import Testing

struct NetworkEnvironmentTests {
    @Test func defaultData() async throws {
        // Given
        let sut = NetworkEnvironment()

        // Then
        #expect(sut.logMode)
    }
}
