public struct Pagination: Equatable, Sendable {
    public let limit: Int
    public let offset: Int
    public let total: Int

    public init(offset: Int, limit: Int, total: Int) {
        self.offset = offset
        self.limit = limit
        self.total = total
    }
}
