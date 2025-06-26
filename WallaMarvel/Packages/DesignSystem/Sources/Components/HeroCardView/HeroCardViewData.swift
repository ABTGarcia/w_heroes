import Foundation

public struct HeroCardViewData: Identifiable, Equatable, Sendable {
    public let id: String
    public let image: String?
    public let name: String
    public let description: String

    public init(
        id: String,
        image: String?,
        name: String,
        description: String) {
        self.id = id
        self.image = image
        self.name = name
        self.description = description
    }
}
