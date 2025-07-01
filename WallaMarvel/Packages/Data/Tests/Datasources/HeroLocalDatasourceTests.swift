@testable import Data
import Domain
import SwiftData
import Testing

// swiftlint:disable force_try
@Suite(.serialized)
class HeroLocalDatasourceTests {
    private var sut: HeroLocalDatasource
    private let heroes = [HeroEntity(
        id: 1,
        name: "WWW",
        image: ImageEntity(iconUrl: "A", smallUrl: "B", screenUrl: "C"),
        apiDetailUrl: "AAAA"
    )]
    private let context = try! ModelContext(
        ModelContainer(for: HeroEntity.self,
                       ImageEntity.self,
                       HeroDetailEntity.self,
                       RelatedSource.self))
    private let hero = HeroDetailEntity(
        id: 1,
        name: "WWW",
        image: ImageEntity(iconUrl: "A", smallUrl: "B", screenUrl: "C"),
        creators: [RelatedSource(id: 2, name: "D", apiDetailUrl: "E")],
        characterFriends: [RelatedSource(id: 3, name: "F", apiDetailUrl: "G")],
        characterEnemies: [RelatedSource(id: 4, name: "H", apiDetailUrl: "I")],
        apiDetailUrl: "AAAA"
    )

    init() async throws {
        sut = HeroLocalDatasource(context: context)
    }

    deinit {
        try! deleteAll(of: HeroEntity.self, context: context)
        try! deleteAll(of: ImageEntity.self, context: context)
        try! deleteAll(of: HeroDetailEntity.self, context: context)
        try! deleteAll(of: RelatedSource.self, context: context)
    }

    @Test func findAll() async throws {
        // Given
        let list = ListEntity(
            limit: 20,
            offset: 0,
            numberOfTotalResults: 1,
            results: heroes
        )

        // When
        try await sut.save(heroes: heroes)
        let result = try await sut.findAll(from: 0, limit: 20)

        // Then
        #expect(result == list)
    }

    @Test func getDetail() async throws {
        // Given
        let url = "AAAA"

        // When
        try await sut.save(heroDetail: hero)
        let result = try await sut.getDetail(withUrl: url)

        // Then
        #expect(result == hero)
    }

    @Test func searchByName() async throws {
        // Given
        let name = "WWW"

        // When
        try await sut.save(heroDetail: hero)
        let result = try await sut.searchByName(name)

        // Then
        #expect(result == heroes)
    }

    func deleteAll<T: PersistentModel>(of _: T.Type, context: ModelContext) throws {
        let descriptor = FetchDescriptor<T>()
        let results = try context.fetch(descriptor)

        for object in results {
            context.delete(object)
        }

        try context.save()
    }
}

// swiftlint:enable force_try
