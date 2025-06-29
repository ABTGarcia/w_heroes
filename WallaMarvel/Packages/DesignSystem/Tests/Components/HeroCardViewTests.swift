@testable import DesignSystem
import TestExtensions
import Testing

struct HeroCardViewTests {
    @Test func initTests() async throws {
        // Given
        let data = HeroCardViewData(
            id: "3",
            image: "AAA",
            name: "BB",
            realName: "FDF",
            description: "CC",
            apiDetailUrl: "J"
        )
        let sut = await HeroCardView(data: data)

        // Then
        await expectSnapshot(matching: sut)
    }
}
