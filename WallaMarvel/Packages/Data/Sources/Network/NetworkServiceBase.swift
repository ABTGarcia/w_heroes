import Foundation

protocol NetworkServiceBaseProtocol {
    var environment: NetworkEnvironmentProtocol { get }
    var logger: NetworkServiceLoggerProtocol { get }
}

extension NetworkServiceBaseProtocol {
    func logRequestIfNeeded(_ urlRequest: URLRequest) {
        guard environment.logMode else { return }
        logger.logRequest(urlRequest)
    }

    func logResponseIfNeeded(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        guard environment.logMode else { return }
        logger.logResponse(data, response, error)
    }

    func urlRequest(endpoint: NetworkEndpointProtocol) -> URLRequest? {
        var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path)
        if let queryParams = endpoint.queryParams {
            urlComponents?.queryItems = queryParams.reduce(into: []) { result, item in
                result.append(URLQueryItem(name: item.key, value: item.value))
            }
        }

        if endpoint.secured {
            // The APIkey should be retrieved in a more secure way, as backend authentication but I don't have it here
            let obfuscated: [UInt8] = [
                98, 56, 50, 56, 48, 54, 54, 102, 98, 54,
                49, 49, 98, 98, 52, 100, 48, 100, 54, 51,
                55, 99, 48, 98, 98, 101, 54, 56, 98, 98,
                57, 48, 102, 50, 99, 51, 57, 49, 51, 52
            ]
            urlComponents?.queryItems?.append(URLQueryItem(name: "api_key", value: String(bytes: obfuscated, encoding: .utf8)))
        }

        guard let url = urlComponents?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = endpoint.cachePolicy
        urlRequest.timeoutInterval = endpoint.timeoutInterval
        urlRequest.httpMethod = endpoint.httpMethod.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = endpoint.headers ?? ["Content-Type": "application/json"]
        urlRequest.httpBody = endpoint.httpBody

        return urlRequest
    }
}
