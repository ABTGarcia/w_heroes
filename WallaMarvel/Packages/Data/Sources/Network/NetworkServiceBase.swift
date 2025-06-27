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
