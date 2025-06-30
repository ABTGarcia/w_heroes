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
        name: "A",
        image: ImageEntity(iconUrl: "C", smallUrl: "D", screenUrl: "E"),
        apiDetailUrl: "B"
    )]
    private let context = try! ModelContext(ModelContainer(for: HeroEntity.self))

    init() async throws {
        sut = HeroLocalDatasource(context: context)

        // I'm saving here to check that in findAll the data will be removed
        try await sut.save(heroes: heroes)
    }

    deinit {
        try! deleteAll(of: HeroEntity.self, context: context)
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
        let result = try await sut.findAll(from: 0, limit: 20)

        // Then
        #expect(result == list)
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
