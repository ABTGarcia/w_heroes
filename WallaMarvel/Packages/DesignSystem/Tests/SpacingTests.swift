import Testing
import CoreGraphics
@testable import DesignSystem

struct SpacingTests {
    @Test func allSpacings() async throws {
        #expect(CGFloat.spacingXXXS == 2)
        #expect(CGFloat.spacingXXS == 4)
        #expect(CGFloat.spacingXS == 8)
        #expect(CGFloat.spacingS == 16)
        #expect(CGFloat.spacingM == 24)
        #expect(CGFloat.spacingL == 32)
        #expect(CGFloat.spacingXL == 40)
        #expect(CGFloat.spacingXXL == 48)
    }
}
