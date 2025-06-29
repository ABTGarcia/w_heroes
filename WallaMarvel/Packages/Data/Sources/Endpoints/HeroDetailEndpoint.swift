import Domain
import Foundation

class HeroDetailEndpoint: NetworkEndpointProtocol {
    var baseURL: String
    var path: String = ""
    var httpMethod: HTTPMethod = .get
    var queryParams: [String: String]? = [
        "format": "json",
        "field_list": "id,name,realName,image,creators,deck,character_friends,character_enemies"
    ]

    init(detailUrl: String) {
        baseURL = detailUrl
    }
}
