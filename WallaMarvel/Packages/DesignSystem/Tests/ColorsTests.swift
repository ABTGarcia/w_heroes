import Testing
import SwiftUI
@testable import DesignSystem

struct ColorsTests {
    @Test func allFColors() async throws {
        #expect(Color.wmMain == Color("Main", bundle: .module))
        #expect(Color.wmSecondary == Color("Secondary", bundle: .module))
        #expect(Color.wmTranspBackground == Color("TranspBackground", bundle: .module))
        #expect(Color.wmSweetBackground == Color("SweetBackground", bundle: .module))
        #expect(Color.wmDreamBackground == Color("DreamBackground", bundle: .module))
        #expect(Color.wmSadBackground == Color("SadBackground", bundle: .module))
        #expect(Color.wmMainText == Color("MainText", bundle: .module))
        #expect(Color.wmSecondaryText == Color("SecondaryText", bundle: .module))
    }
}
