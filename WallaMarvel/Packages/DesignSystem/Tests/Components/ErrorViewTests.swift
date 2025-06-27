import Testing
@testable import DesignSystem
import TestExtensions

struct ErrorViewTests {
    @Test func initTests() async throws {
        // Given
        let sut = await ErrorView {}

        // Then
        await expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }

    @Test func customText() async throws {
        // Given
        let sut = await ErrorView(errorTitle: "AAA", errorMessage: "BBB") {}

        // Then
        await expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
