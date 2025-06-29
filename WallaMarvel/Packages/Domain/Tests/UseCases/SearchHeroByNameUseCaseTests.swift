@testable import Domain
import FactoryKit
import Foundation
import TestExtensions
import Testing

struct SearchHeroByNameUseCaseTests {
    private var sut: SearchHeroByNameUseCase
    private let heroRepository = HeroRepositoryProtocolMock()
    private let container: Container

    private let heroes = [Hero(id: "1", image: "AAA", thumbnail: "G", name: "BBB", realName: "FDF", description: "CCC", apiDetailUrl: "J")]

    init() {
        container = Container()
        sut = SearchHeroByNameUseCase(container: container)
        setDependencies()
    }

    @Test mutating func firstInvoke() async throws {
        // Given
        heroRepository.searchByNameReturnValue = heroes

        // When
        let result = try await sut.invoke("AAA")

        // Then
        #expect(heroRepository.searchByNameCallsCount == 1)
        #expect(result == heroes)
    }

    @Test mutating func emptyNameReturnsNil() async throws {
        // Given
        heroRepository.searchByNameReturnValue = heroes

        // When
        let result = try await sut.invoke("")

        // Then
        #expect(heroRepository.searchByNameCallsCount == 0)
        #expect(result == nil)
    }

    @Test mutating func minLetters() async throws {
        // Given
        heroRepository.searchByNameReturnValue = heroes

        // When
        let result = try await sut.invoke("ab")

        // Then
        #expect(heroRepository.searchByNameCallsCount == 0)
        #expect(result == nil)
    }

    private func setDependencies() {
        container.heroRepository.register { heroRepository }
    }
}
