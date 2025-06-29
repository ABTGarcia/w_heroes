import FactoryKit
import Foundation

// sourcery: AutoMockable
public protocol SearchHeroByNameUseCaseProtocol: Sendable {
    mutating func invoke(_ name: String) async throws -> [Hero]?
}

public struct SearchHeroByNameUseCase: SearchHeroByNameUseCaseProtocol {
    private let container: Container
    private let throttleIntervalSeconds: TimeInterval = 1
    private let minletters = 3
    private var lastRequestDate: Date?

    public init(container: Container = .shared) {
        self.container = container
    }

    public mutating func invoke(_ name: String) async throws -> [Hero]? {
        guard let repository = container.heroRepository() else {
            preconditionFailure("Repository not found")
        }

        lastRequestDate = Date.now

        guard !name.isEmpty, name.count >= minletters else {
            return nil
        }

        try? await Task.sleep(nanoseconds: UInt64(throttleIntervalSeconds * 1_000_000_000))

        if let last = lastRequestDate, Date.now.timeIntervalSince(last) < throttleIntervalSeconds {
            return nil
        }

        return try await repository.searchByName(name)
    }
}
