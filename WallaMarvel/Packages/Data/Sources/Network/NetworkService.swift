import Combine
import Domain
import Foundation

// sourcery: AutoMockable
public protocol NetworkServiceProtocol: Sendable {
    func request<T: Decodable>(with endpoint: NetworkEndpointProtocol) async throws -> T
    func requestImage(with endpoint: NetworkEndpointProtocol) async throws -> Data
}

public final class NetworkService: NSObject, NetworkServiceProtocol, NetworkServiceBaseProtocol {
    let environment: NetworkEnvironmentProtocol
    let logger: NetworkServiceLoggerProtocol
    let session: URLSession = .init(configuration: .default)

    public init(environment: NetworkEnvironmentProtocol, logger: NetworkServiceLoggerProtocol) {
        self.environment = environment
        self.logger = logger
        super.init()
    }

    public func request<T: Decodable>(with endpoint: NetworkEndpointProtocol) async throws -> T {
        guard let session = initializeSession(with: endpoint), let urlRequest = urlRequest(endpoint: endpoint) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(for: urlRequest)
        logResponseIfNeeded(data: data, response: response)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        guard (200 ... 299).contains(response.statusCode) else {
            throw NetworkError.httpError(response.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }

    public func requestImage(with endpoint: NetworkEndpointProtocol) async throws -> Data {
        guard let session = initializeSession(with: endpoint), let urlRequest = urlRequest(endpoint: endpoint) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(for: urlRequest)
        logResponseIfNeeded(data: data, response: response)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        guard (200 ... 299).contains(response.statusCode) else {
            throw NetworkError.httpError(response.statusCode)
        }

        guard response.value(forHTTPHeaderField: "Content-Type") == "image/png" ||
            response.value(forHTTPHeaderField: "Content-Type") == "image/jpg"
        else {
            throw NetworkError.decodingError
        }

        return data
    }
}

// MARK: -

private extension NetworkService {
    func initializeSession(with endpoint: NetworkEndpointProtocol) -> URLSession? {
        guard let urlRequest = urlRequest(endpoint: endpoint) else { return nil }

        logRequestIfNeeded(urlRequest)
        return session
    }
}
