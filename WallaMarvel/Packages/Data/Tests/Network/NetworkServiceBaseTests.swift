@testable import Data
import Foundation
import Testing

struct NetworkServiceBaseTests {
    let loggerMock = NetworkServiceLoggerProtocolMock()
    let environmentMock = NetworkEnvironmentProtocolMock()
    let urlRequest = URLRequest(url: URL(string: "https://apple.com")!)

    @Test func logRequest() {
        // Given
        environmentMock.underlyingLogMode = true
        let sut = NetworkServiceBaseMock(environment: environmentMock, logger: loggerMock)

        // When
        sut.logRequestIfNeeded(urlRequest)

        // Then
        #expect(loggerMock.logRequestReceivedLogRequest == urlRequest)
    }

    @Test func logRequestNotLogging() {
        // Given
        environmentMock.underlyingLogMode = false
        let sut = NetworkServiceBaseMock(environment: environmentMock, logger: loggerMock)

        // When
        sut.logRequestIfNeeded(urlRequest)

        // Then
        #expect(!loggerMock.logRequestCalled)
    }

    @Test func logResponseIfNeeded() {
        // Given
        environmentMock.underlyingLogMode = true
        let sut = NetworkServiceBaseMock(environment: environmentMock, logger: loggerMock)
        let data = Data()
        let response = URLResponse()
        let error = NetworkError.decodingError

        // When
        sut.logResponseIfNeeded(data: data, response: response, error: error)

        // Then
        #expect(loggerMock.logResponseReceivedArguments?.data == data)
        #expect(loggerMock.logResponseReceivedArguments?.response == response)
        #expect(loggerMock.logResponseReceivedArguments?.error as? NetworkError == error)
    }

    @Test func logResponseIfNeededNotLogging() {
        // Given
        environmentMock.underlyingLogMode = false
        let sut = NetworkServiceBaseMock(environment: environmentMock, logger: loggerMock)
        let data = Data()
        let response = URLResponse()
        let error = NetworkError.decodingError

        // When
        sut.logResponseIfNeeded(data: data, response: response, error: error)

        // Then
        #expect(!loggerMock.logResponseCalled)
    }

    @Test func urlRequestDefaultValues() {
        // Given
        var endpoint = EndpointMock()
        endpoint.path = "test"
        let sut = NetworkServiceBaseMock(environment: environmentMock, logger: loggerMock)

        // When
        let request = sut.urlRequest(endpoint: endpoint)

        // Then
        #expect(request?.cachePolicy == endpoint.cachePolicy)
        #expect(request?.timeoutInterval == endpoint.timeoutInterval)
        #expect(request?.httpMethod == endpoint.httpMethod.rawValue.uppercased())
        #expect(request?.allHTTPHeaderFields == ["Content-Type": "application/json"])
        #expect(request?.httpBody == endpoint.httpBody)
        #expect(request?.url?.absoluteString == "https://comicvine.gamespot.com/api/test?format=json&api_key=b828066fb611bb4d0d637c0bbe68bb90f2c39134")
    }

    struct NetworkServiceBaseMock: NetworkServiceBaseProtocol {
        var logger: any NetworkServiceLoggerProtocol
        var environment: any NetworkEnvironmentProtocol

        init(environment: NetworkEnvironmentProtocolMock, logger: NetworkServiceLoggerProtocolMock) {
            self.environment = environment
            self.logger = logger
        }
    }

    struct EndpointMockHeadersParams: NetworkEndpointProtocol {
        var path = "test"
        var headers = ["AA": "BB"]
        var queryParams = ["CCC": "DDD"]
    }

    struct EndpointMock: NetworkEndpointProtocol {
        var path = "test"
    }
}
