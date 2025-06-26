import Testing
@testable import Presentation
import FactoryKit
import TestExtensions

@MainActor
struct HeroesListViewModelTests {
    private var sut: HeroesListViewModel!
    private let container: Container
    private let listData = HeroesListViewData(list: [
        HeroeViewData(id: "1", image: "https://picsum.photos/100", name: "A"),
        HeroeViewData(id: "2", image: "https://picsum.photos/100", name: "B"),
        HeroeViewData(id: "3", image: "", name: "C")
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
