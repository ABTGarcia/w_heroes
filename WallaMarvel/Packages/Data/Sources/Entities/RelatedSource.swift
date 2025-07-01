import SwiftData

@Model
class RelatedSource: Codable, Equatable {
    var id: Int
    var name: String
    var apiDetailUrl: String

    init(id: Int, name: String, apiDetailUrl: String) {
        self.id = id
        self.name = name
        self.apiDetailUrl = apiDetailUrl
    }

    enum CodingKeys: CodingKey {
        case id, name, apiDetailUrl
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        apiDetailUrl = try container.decode(String.self, forKey: .apiDetailUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(apiDetailUrl, forKey: .apiDetailUrl)
    }
}
