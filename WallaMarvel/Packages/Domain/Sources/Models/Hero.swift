public struct Hero: Equatable, Sendable {
    public let id: String
    public let image: String
    public let thumbnail: String
    public let name: String
    public let realName: String?
    public let description: String?
    public let apiDetailUrl: String

    public init(id: String, image: String, thumbnail: String, name: String, realName: String?, description: String?, apiDetailUrl: String) {
        self.id = id
        self.image = image
        self.thumbnail = thumbnail
        self.name = name
        self.realName = realName
        self.description = description
        self.apiDetailUrl = apiDetailUrl
    }
}
