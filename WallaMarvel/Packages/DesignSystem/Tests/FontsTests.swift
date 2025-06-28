import Testing
import SwiftUI
import CoreGraphics
@testable import DesignSystem

struct FontsTests {
    @Test func allFonts() async throws {
        #expect(Font.wmHeader == Font.system(size: 28, weight: .bold))
        #expect(Font.wmTitle == Font.system(size: 18, weight: .bold))
        #expect(Font.wmDescription == Font.system(size: 16))
        #expect(Font.wmSmallText == Font.system(size: 12))
    }
}
