import Domain
import Foundation
import SwiftData

// sourcery: AutoMockable
protocol HeroLocalDatasourceProtocol {
    func findAll(from position: Int, limit: Int) async throws -> ListEntity<[HeroEntity]>
    func save(heroes: [HeroEntity]) async throws
}

final class HeroLocalDatasource: HeroLocalDatasourceProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func findAll(from position: Int, limit: Int) async throws -> ListEntity<[HeroEntity]> {
        var descriptor = FetchDescriptor<HeroEntity>(
            predicate: nil,
            sortBy: [SortDescriptor(\.id, order: .forward)]
        )
        let total = try context.fetchCount(descriptor)

        descriptor.fetchOffset = position
        descriptor.fetchLimit = limit
        let heroes = try context.fetch(descriptor)

        return ListEntity(
            limit: limit,
            offset: position,
            numberOfTotalResults: total,
            results: heroes
        )
    }

    public func save(heroes: [HeroEntity]) async throws {
        for hero in heroes {
            let fetchDescriptor = FetchDescriptor<HeroEntity>(
                predicate: #Predicate { $0.id == hero.id }
            )

            if let existing = try? context.fetch(fetchDescriptor).first {
                existing.name = hero.name
                existing.realName = hero.realName
                existing.deck = hero.deck
                existing.image = hero.image
                existing.apiDetailUrl = hero.apiDetailUrl

            } else {
                context.insert(hero)
            }
        }
        try context.save()
    }
}
