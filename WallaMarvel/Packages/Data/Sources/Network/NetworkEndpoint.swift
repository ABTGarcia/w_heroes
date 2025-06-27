import Foundation

public protocol NetworkEndpointProtocol {
    var baseURL: String { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var headers: [String: String]? { get }
    var httpBody: Data? { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var queryParams: [String: String]? { get }
    var timeoutInterval: TimeInterval { get }
}

public extension NetworkEndpointProtocol {
    var baseURL: String { "http://localhost:8080/api/" }
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    var httpBody: Data? { nil }
    var httpMethod: HTTPMethod { .get }
    var queryParams: [String: String]? { nil }
    var headers: [String: String]? { nil }
    var timeoutInterval: TimeInterval { 10.0 }
}
