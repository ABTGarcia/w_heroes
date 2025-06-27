import Testing
@testable import Data
import Domain

struct ListEntityTests {
    @Test func domainPagination() async throws {
        // Given
        let expected = Pagination(offset: 2, limit: 1, total: 3)
        let sut = ListEntity(
            limit: 1,
            offset: 2,
            numberOfTotalResults: 3,
            results: HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "D", screenUrl: "E")))

        // When
        let result = sut.domainPagination()

        // Then
        #expect(result == expected)
    }
}
