@testable import DesignSystem
import SwiftUI
import TestExtensions
import Testing

struct SearchResultsCardViewTests {
    @Test func results() async throws {
        // Given
        let sut = await SearchResultsCardView(result: SearchResultsCardViewData(id: "1", name: "AAA", thumbnail: "S", apiDetailUrl: "d"))

        // Then
        await expectSnapshot(matching: sut)
    }
}
