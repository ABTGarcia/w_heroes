@testable import DesignSystem
import SwiftUI
import TestExtensions
import Testing

struct SearchFieldViewTests {
    @Test func withSearchText() async throws {
        // Given
        let sut = await SearchFieldView(searchText: Binding.constant("AA"), clearButtonClosure: {})

        // Then
        await expectSnapshot(matching: sut)
    }

    @Test func withoutSearchText() async throws {
        // Given
        let sut = await SearchFieldView(searchText: Binding.constant(""), clearButtonClosure: {})

        // Then
        await expectSnapshot(matching: sut)
    }
}
