import Domain
import Foundation

class HeroesListEndpoint: NetworkEndpointProtocol {
    var path: String = "characters"
    var httpMethod: HTTPMethod = .get
}
