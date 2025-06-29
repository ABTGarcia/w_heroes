@testable import DesignSystem
import TestExtensions
import Testing

struct LoadingViewTests {
    @Test func initTests() async {
        // Given
        let sut = await LoadingView()

        // Then
        await expectSnapshot(matching: sut)
    }
}
