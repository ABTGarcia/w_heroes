import Testing
@testable import DesignSystem
import TestExtensions

struct HeroCardViewTests {
    @Test func initTests() async throws {
        // Given
        let data = HeroCardViewData(
            id: "3",
            image: "AAA",
            name: "BB",
            description: "CC")
        let sut = await HeroCardView(data: data)

        // Then
        await expectSnapshot(matching: sut)
    }
}
