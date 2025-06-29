import Foundation

public struct HeroCardViewData: Identifiable, Equatable, Sendable {
    public let id: String
    public let image: String?
    public let name: String
    public let realName: String?
    public let description: String?
    public let apiDetailUrl: String

    public init(
        id: String,
        image: String?,
        name: String,
        realName: String?,
        description: String?,
        apiDetailUrl: String
    ) {
        self.id = id
        self.image = image
        self.name = name
        self.realName = realName
        self.description = description
        self.apiDetailUrl = apiDetailUrl
    }
}
