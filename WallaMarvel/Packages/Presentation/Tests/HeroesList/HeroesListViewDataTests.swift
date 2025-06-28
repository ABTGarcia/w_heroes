import Testing
@testable import Presentation
import Domain
import DesignSystem

@MainActor
struct HeroesListViewDataTests {
    private let heroes = [Hero(id: "1", image: "A", name: "B", description: "C")]
    private let moreHeroes = [Hero(id: "2", image: "B", name: "C", description: "D")]

    @Test func initTests() async throws {
        // Given
        let sut = HeroesListViewData(heroes: heroes, isLoading: true)

        // Then
        #expect(sut.isLoading == true)
        #expect(sut.list == [HeroCardViewData(id: "1", image: "A", name: "B", description: "C")])
    }

    @Test func appendHeroes() async throws {
        // Given
        var sut = HeroesListViewData(heroes: heroes, isLoading: true)

        // When
        sut.appendHeroes(moreHeroes)

        // Then
        #expect(sut.isLoading == true)
        #expect(sut.list == [
            HeroCardViewData(id: "1", image: "A", name: "B", description: "C"),
            HeroCardViewData(id: "2", image: "B", name: "C", description: "D")
        ])
    }
}
