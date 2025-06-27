public struct Pagination: Equatable, Sendable {
    let limit: Int
    let offset: Int
    let total: Int

    public init(offset: Int, limit: Int, total: Int) {
        self.offset = offset
        self.limit = limit
        self.total = total
    }
}
