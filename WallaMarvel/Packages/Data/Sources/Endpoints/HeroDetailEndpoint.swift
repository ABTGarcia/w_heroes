import Domain
import Foundation

class HeroDetailEndpoint: NetworkEndpointProtocol {
    var baseURL: String
    var path: String = ""
    var httpMethod: HTTPMethod = .get

    init(detailUrl: String) {
        baseURL = detailUrl
    }
}
