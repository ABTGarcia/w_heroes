public struct SearchResultsCardViewData: Identifiable, Equatable, Sendable {
    public let id: String
    let name: String
    let thumbnail: String
    public let apiDetailUrl: String

    public init(id: String, name: String, thumbnail: String, apiDetailUrl: String) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.apiDetailUrl = apiDetailUrl
    }
}
