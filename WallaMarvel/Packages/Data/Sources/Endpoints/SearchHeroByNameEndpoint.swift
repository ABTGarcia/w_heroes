import Domain
import Foundation

class SearchHeroByNameEndpoint: NetworkEndpointProtocol {
    var path: String = "search"
    var httpMethod: HTTPMethod = .get
    var queryParams: [String: String]? = [:]

    init(_ name: String) {
        queryParams = [
            "limit": "100",
            "format": "json",
            "query": "name:\(name)",
            "resources": "character",
            "field_list": "id,name,api_detail_url,image,real_name,deck"
        ]
    }
}
