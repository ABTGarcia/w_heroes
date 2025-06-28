import Testing
@testable import DesignSystem
import TestExtensions

struct SectionCardViewTests {
    @Test func initTests() async throws {
        // Given
        let data = SectionCardViewData(
            name: "AAAAA",
            systemImageName: "heart.fill",
            content: ["Adwa", "fdswef", "fewe"],
            backgroundColor: .wmDreamBackground)
        let sut = await SectionCardView(data: data)

        // Then
        await expectSnapshot(matching: sut)
    }
}
