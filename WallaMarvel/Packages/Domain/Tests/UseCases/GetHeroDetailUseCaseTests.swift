@testable import Domain
import FactoryKit
import Foundation
import TestExtensions
import Testing

struct GetHeroDetailUseCaseTests {
    private var sut: GetHeroDetailUseCase
    private let heroRepository = HeroRepositoryProtocolMock()
    private let container: Container
    private let heroDetail = HeroDetail(
        name: "A",
        image: "B",
        creators: ["C"],
        friends: ["D"],
        enemies: ["E"]
    )

    init() {
        container = Container()
        sut = GetHeroDetailUseCase(container: container)
        setDependencies()
    }

    @Test mutating func invoke() async throws {
        // Given
        let detailUrl = "AAA"
        heroRepository.getDetailWithUrlReturnValue = heroDetail

        // When
        let result = try await sut.invoke(detailUrl: detailUrl)

        // Then
        #expect(heroRepository.getDetailWithUrlReceivedUrl == detailUrl)
        #expect(result == heroDetail)
    }

    private func setDependencies() {
        container.heroRepository.register { heroRepository }
    }
}
