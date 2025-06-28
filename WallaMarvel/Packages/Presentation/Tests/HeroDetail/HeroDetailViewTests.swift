import Testing
import SwiftUI
@testable import Presentation
import TestExtensions
import DesignSystem
import Foundation
import Domain

@MainActor
struct HeroDetailViewTests {
    private let sut: HeroDetailView<HeroDetailViewModelProtocolMock>
    private var viewModel = HeroDetailViewModelProtocolMock()

    init() {
        sut = HeroDetailView(viewModel: viewModel)
    }

    @Test func initTest() async throws {
        // Given

        // Then
        expectSnapshot(matching: sut, size: .iPhone16Portrait)
    }
}
