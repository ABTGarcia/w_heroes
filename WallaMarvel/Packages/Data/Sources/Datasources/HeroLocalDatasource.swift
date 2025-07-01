import Domain
import Foundation
import SwiftData

// sourcery: AutoMockable
protocol HeroLocalDatasourceProtocol {
    func findAll(from position: Int, limit: Int) async throws -> ListEntity<[HeroEntity]>
    func getDetail(withUrl url: String) async throws -> HeroDetailEntity
    func searchByName(_ name: String) async throws -> [HeroEntity]
    func save(heroes: [HeroEntity]) async throws
    func save(heroDetail: HeroDetailEntity) async throws
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

    func getDetail(withUrl: String) async throws -> HeroDetailEntity {
        let descriptor = FetchDescriptor<HeroDetailEntity>(
            predicate: #Predicate { $0.apiDetailUrl == withUrl }
        )

        guard let heroDetail = try context.fetch(descriptor).first else {
            throw LocalDataError.noDataFound
        }

        return heroDetail
    }

    func searchByName(_ name: String) async throws -> [HeroEntity] {
        let descriptor = FetchDescriptor<HeroDetailEntity>(
            predicate: #Predicate {
                $0.name.localizedStandardContains(name)
            }
        )

        let heroesDetail = try context.fetch(descriptor)

        let heroes = heroesDetail.map { HeroEntity(
            id: $0.id,
            name: $0.name,
            realName: $0.realName,
            deck: $0.deck,
            image: $0.image,
            apiDetailUrl: $0.apiDetailUrl ?? ""
        ) }

        return heroes
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

    public func save(heroDetail: HeroDetailEntity) async throws {
        let fetchDescriptor = FetchDescriptor<HeroDetailEntity>(
            predicate: #Predicate { $0.id == heroDetail.id }
        )

        if let existing = try? context.fetch(fetchDescriptor).first {
            existing.name = heroDetail.name
            existing.realName = heroDetail.realName
            existing.deck = heroDetail.deck
            existing.image = heroDetail.image
            existing.creators = heroDetail.creators
            existing.characterFriends = heroDetail.characterFriends
            existing.characterEnemies = heroDetail.characterEnemies
            existing.apiDetailUrl = heroDetail.apiDetailUrl
        } else {
            context.insert(heroDetail)
        }
        try context.save()
    }
}
