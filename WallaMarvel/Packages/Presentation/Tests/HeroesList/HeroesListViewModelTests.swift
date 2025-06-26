import Testing
@testable import Presentation
import FactoryKit
import TestExtensions
import DesignSystem

@MainActor
struct HeroesListViewModelTests {
    private var sut: HeroesListViewModel!
    private let container: Container
    private let listData = HeroesListViewData(list: [
        HeroCardViewData(id: "1", image: "https://picsum.photos/100", name: "A", description: "orem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut"),
        HeroCardViewData(id: "2", image: "https://picsum.photos/100", name: "B", description: "orem ipsum dotempor incididunt ut labore"),
        HeroCardViewData(id: "3", image: "", name: "C", description: "")
    ])

    init() {
        container = Container()
        sut = HeroesListViewModel(container: container)
    }

    @Test func initTests() async throws {
        // Then
        #expect(sut.state == .loading)
    }

    @Test func loadData() async throws {
        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == .loaded(listData))
    }
}
