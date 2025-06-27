public struct Pagination: Equatable, Sendable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int

    public init(offset: Int, limit: Int, total: Int, count: Int) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
    }
}
