import DesignSystem
import Domain
import FactoryKit
@testable import Presentation
import TestExtensions
import Testing

@MainActor
struct HeroDetailViewModelTests {
    private var sut: HeroDetailViewModel!
    private let container: Container
    private let heroesList = HeroesList(
        heroes: [Hero(id: "1", image: "A", name: "B", description: "C")],
        pagination: Pagination(offset: 1, limit: 2, total: 5)
    )

    init() {
        container = Container()
        sut = HeroDetailViewModel(detailUrl: "", container: container)
    }

    @Test func initTests() async throws {
        // Then
        #expect(sut.state == .loading)
    }
}
