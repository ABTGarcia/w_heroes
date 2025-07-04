import Domain

struct ListEntity<DataType: Codable & Equatable>: Codable, Equatable {
    let limit: Int
    let offset: Int
    let numberOfTotalResults: Int
    let results: DataType

    public func domainPagination() -> Pagination {
        Pagination(offset: offset, limit: limit, total: numberOfTotalResults)
    }
}
