import Testing
@testable import Data

struct NetworkEnvironmentTests {
    @Test func defaultData() async throws {
        // Given
        let sut = NetworkEnvironment()

        // Then
        #expect(sut.logMode)
    }
}
