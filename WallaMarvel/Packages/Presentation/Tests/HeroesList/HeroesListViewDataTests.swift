import DesignSystem
import Domain
@testable import Presentation
import Testing

@MainActor
struct HeroesListViewDataTests {
    private let heroes = [Hero(id: "1", image: "A", thumbnail: "F", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")]
    private let moreHeroes = [Hero(id: "2", image: "B", thumbnail: "F", name: "C", realName: "FDF", description: "D", apiDetailUrl: "J")]

    @Test func initTests() async throws {
        // Given
        let sut = HeroesListViewData(heroes: heroes, isLoading: true, searchList: [])

        // Then
        #expect(sut.isLoading == true)
        #expect(sut.list == [HeroCardViewData(id: "1", image: "A", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J")])
    }

    @Test func appendHeroes() async throws {
        // Given
        var sut = HeroesListViewData(heroes: heroes, isLoading: true, searchList: [])

        // When
        sut.appendHeroes(moreHeroes)

        // Then
        #expect(sut.isLoading == true)
        #expect(sut.list == [
            HeroCardViewData(id: "1", image: "A", name: "B", realName: "FDF", description: "C", apiDetailUrl: "J"),
            HeroCardViewData(id: "2", image: "B", name: "C", realName: "FDF", description: "D", apiDetailUrl: "J")
        ])
    }
}
