import Foundation
import SwiftData

@Model
class ImageEntity: Codable, Equatable {
    @Attribute(.unique) var id: UUID = UUID()
    var iconUrl: String
    var smallUrl: String
    var screenUrl: String

    init(iconUrl: String, smallUrl: String, screenUrl: String) {
        self.iconUrl = iconUrl
        self.smallUrl = smallUrl
        self.screenUrl = screenUrl
    }

    enum CodingKeys: CodingKey {
        case iconUrl, smallUrl, screenUrl
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iconUrl = try container.decode(String.self, forKey: .iconUrl)
        smallUrl = try container.decode(String.self, forKey: .smallUrl)
        screenUrl = try container.decode(String.self, forKey: .screenUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(iconUrl, forKey: .iconUrl)
        try container.encode(smallUrl, forKey: .smallUrl)
        try container.encode(screenUrl, forKey: .screenUrl)
    }

    static func == (lhs: ImageEntity, rhs: ImageEntity) -> Bool {
        lhs.iconUrl == rhs.iconUrl && lhs.smallUrl == rhs.smallUrl && lhs.screenUrl == rhs.screenUrl
    }
}
