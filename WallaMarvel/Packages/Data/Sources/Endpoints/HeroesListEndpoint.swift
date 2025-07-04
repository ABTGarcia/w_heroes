import Domain
import Foundation

class HeroesListEndpoint: NetworkEndpointProtocol {
    var path: String = "characters"
    var httpMethod: HTTPMethod = .get
    var queryParams: [String: String]? = [:]

    init(from position: Int, limit: Int) {
        queryParams = [
            "limit": String(limit),
            "format": "json",
            "offset": String(position),
            "field_list": "id,name,api_detail_url,image,real_name,deck"
        ]
    }
}
