@testable import Data
import Domain
import Testing

struct ListEntityTests {
    @Test func domainPagination() async throws {
        // Given
        let expected = Pagination(offset: 2, limit: 1, total: 3)
        let sut = ListEntity(
            limit: 1,
            offset: 2,
            numberOfTotalResults: 3,
            results: HeroEntity(id: 1, name: "A", realName: "B", deck: "C", image: ImageEntity(iconUrl: "S", smallUrl: "D", screenUrl: "E"), apiDetailUrl: "J")
        )

        // When
        let result = sut.domainPagination()

        // Then
        #expect(result == expected)
    }
}
