import Domain
import Foundation

class HeroesListEndpoint: NetworkEndpointProtocol {
    var path: String = "characters"
    var httpMethod: HTTPMethod = .get
    var queryParams: [String: String]? = [:]

    init(from position: Int) {
        self.queryParams = ["limit": "20", "format": "json", "offset": String(position)]
    }
}
