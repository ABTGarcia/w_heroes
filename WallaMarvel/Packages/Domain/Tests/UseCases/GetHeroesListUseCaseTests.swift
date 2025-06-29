@testable import Domain
import FactoryKit
import Foundation
import TestExtensions
import Testing

struct GetHeroesListUseCaseTests {
    private var sut: GetHeroesListUseCase
    private let heroRepository = HeroRepositoryProtocolMock()
    private let container: Container

    private let heroesList = HeroesList(
        heroes: [
            Hero(id: "1", image: "AAA", thumbnail: "G", name: "BBB", realName: "FDF", description: "CCC", apiDetailUrl: "J")
        ],
        pagination: Pagination(offset: 0, limit: 20, total: 30)
    )

    init() {
        container = Container()
        sut = GetHeroesListUseCase(container: container)
        setDependencies()
    }

    @Test mutating func firstInvoke() async throws {
        // Given
        heroRepository.findAllFromReturnValue = heroesList

        // When
        let result = try await sut.invoke(lastId: nil)

        // Then
        #expect(heroRepository.findAllFromCallsCount == 1)
        #expect(result == heroesList)
    }

    @Test mutating func consecutiveInvokeWithRequestedIdInLastOnes() async throws {
        // Given
        heroRepository.findAllFromReturnValue = heroesList

        // When
        _ = try await sut.invoke(lastId: nil)
        let result = try await sut.invoke(lastId: "1")

        // Then
        #expect(heroRepository.findAllFromCallsCount == 2)
        #expect(result == heroesList)
    }

    @Test mutating func heroesExceedsTotal() async throws {
        // Given
        let pagination = Pagination(offset: 20, limit: 20, total: 1)
        let heroesList = HeroesList(
            heroes: [
                Hero(id: "1", image: "AAA", thumbnail: "E", name: "BBB", realName: "FDF", description: "CCC", apiDetailUrl: "J"),
                Hero(id: "2", image: "BBB", thumbnail: "E", name: "CCC", realName: "FDF", description: "DDD", apiDetailUrl: "J")
            ],
            pagination: pagination
        )
        heroRepository.findAllFromReturnValue = heroesList

        // When
        _ = try await sut.invoke(lastId: nil)
        let result = try await sut.invoke(lastId: nil)

        // Then
        #expect(heroRepository.findAllFromCallsCount == 1)
        #expect(result == HeroesList(heroes: [], pagination: pagination))
    }

    @Test mutating func requestedIdIsNotInTheLastsOnes() async throws {
        // Given
        let pagination = Pagination(offset: 1, limit: 2, total: 30)
        let heroesList = HeroesList(
            heroes: [
                Hero(id: "1", image: "AAA", thumbnail: "E", name: "BBB", realName: "FDF", description: "CCC", apiDetailUrl: "J")
            ],
            pagination: pagination
        )
        heroRepository.findAllFromReturnValue = heroesList

        // When
        _ = try await sut.invoke(lastId: nil)
        let result = try await sut.invoke(lastId: "5")

        // Then
        #expect(heroRepository.findAllFromCallsCount == 1)
        #expect(result == HeroesList(heroes: [], pagination: pagination))
    }

    @Test mutating func canRequestMoreAfterThrowingError() async throws {
        // Given
        heroRepository.findAllFromThrowableError = TestError.genericError

        // When
        await #expect(throws: TestError.self) {
            _ = try await sut.invoke(lastId: nil)
        }
        await #expect(throws: TestError.self) {
            _ = try await sut.invoke(lastId: nil)
        }

        // Then
        #expect(heroRepository.findAllFromCallsCount == 2)
    }

    private func setDependencies() {
        container.heroRepository.register { heroRepository }
    }

    private enum TestError: Error {
        case genericError
    }
}
