// Generated using Sourcery 2.2.6 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable superfluous_disable_command
// swiftlint:disable line_length
// swiftlint:disable variable_name
// swiftlint:disable force_cast
// swiftlint:disable large_tuple

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

import Domain

@testable import Data

class HeroDatasourceProtocolMock: HeroDatasourceProtocol, @unchecked Sendable {
    // MARK: - findAll

    var findAllFromThrowableError: (any Error)?
    var findAllFromCallsCount = 0
    var findAllFromCalled: Bool {
        findAllFromCallsCount > 0
    }

    var findAllFromReceivedPosition: Int?
    var findAllFromReceivedInvocations: [Int] = []
    var findAllFromReturnValue: ListEntity<[HeroEntity]>!
    var findAllFromClosure: ((Int) async throws -> ListEntity<[HeroEntity]>)?

    func findAll(from position: Int) async throws -> ListEntity<[HeroEntity]> {
        findAllFromCallsCount += 1
        findAllFromReceivedPosition = position
        findAllFromReceivedInvocations.append(position)
        if let error = findAllFromThrowableError {
            throw error
        }
        if let findAllFromClosure {
            return try await findAllFromClosure(position)
        } else {
            return findAllFromReturnValue
        }
    }
}

public class NetworkEnvironmentProtocolMock: NetworkEnvironmentProtocol, @unchecked Sendable {
    public init() {}

    public var logMode: Bool {
        get { underlyingLogMode }
        set(value) { underlyingLogMode = value }
    }

    public var underlyingLogMode: Bool!
}

public class NetworkServiceLoggerProtocolMock: NetworkServiceLoggerProtocol, @unchecked Sendable {
    public init() {}

    // MARK: - logResponse

    public var logResponseCallsCount = 0
    public var logResponseCalled: Bool {
        logResponseCallsCount > 0
    }

    public var logResponseReceivedArguments: (data: Data?, response: URLResponse?, error: Error?)?
    public var logResponseReceivedInvocations: [(data: Data?, response: URLResponse?, error: Error?)] = []
    public var logResponseClosure: ((Data?, URLResponse?, Error?) -> Void)?

    public func logResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        logResponseCallsCount += 1
        logResponseReceivedArguments = (data: data, response: response, error: error)
        logResponseReceivedInvocations.append((data: data, response: response, error: error))
        logResponseClosure?(data, response, error)
    }

    // MARK: - logRequest

    public var logRequestCallsCount = 0
    public var logRequestCalled: Bool {
        logRequestCallsCount > 0
    }

    public var logRequestReceivedLogRequest: URLRequest?
    public var logRequestReceivedInvocations: [URLRequest] = []
    public var logRequestClosure: ((URLRequest) -> Void)?

    public func logRequest(_ logRequest: URLRequest) {
        logRequestCallsCount += 1
        logRequestReceivedLogRequest = logRequest
        logRequestReceivedInvocations.append(logRequest)
        logRequestClosure?(logRequest)
    }
}

public class NetworkServiceProtocolMock: NetworkServiceProtocol, @unchecked Sendable {
    public init() {}

    // MARK: - request<T: Decodable>

    public var requestWithThrowableError: (any Error)?
    public var requestWithCallsCount = 0
    public var requestWithCalled: Bool {
        requestWithCallsCount > 0
    }

    public var requestWithReceivedEndpoint: NetworkEndpointProtocol?
    public var requestWithReceivedInvocations: [NetworkEndpointProtocol] = []
    public var requestWithReturnValue: Any!
    public var requestWithClosure: ((NetworkEndpointProtocol) async throws -> Any)?

    public func request<T: Decodable>(with endpoint: NetworkEndpointProtocol) async throws -> T {
        requestWithCallsCount += 1
        requestWithReceivedEndpoint = endpoint
        requestWithReceivedInvocations.append(endpoint)
        if let error = requestWithThrowableError {
            throw error
        }
        if let requestWithClosure {
            return try await requestWithClosure(endpoint) as! T
        } else {
            return requestWithReturnValue as! T
        }
    }

    // MARK: - requestImage

    public var requestImageWithThrowableError: (any Error)?
    public var requestImageWithCallsCount = 0
    public var requestImageWithCalled: Bool {
        requestImageWithCallsCount > 0
    }

    public var requestImageWithReceivedEndpoint: NetworkEndpointProtocol?
    public var requestImageWithReceivedInvocations: [NetworkEndpointProtocol] = []
    public var requestImageWithReturnValue: Data!
    public var requestImageWithClosure: ((NetworkEndpointProtocol) async throws -> Data)?

    public func requestImage(with endpoint: NetworkEndpointProtocol) async throws -> Data {
        requestImageWithCallsCount += 1
        requestImageWithReceivedEndpoint = endpoint
        requestImageWithReceivedInvocations.append(endpoint)
        if let error = requestImageWithThrowableError {
            throw error
        }
        if let requestImageWithClosure {
            return try await requestImageWithClosure(endpoint)
        } else {
            return requestImageWithReturnValue
        }
    }
}

// swiftlint:enable line_length
// swiftlint:enable variable_name
// swiftlint:enable superfluous_disable_command
// swiftlint:enable force_cast
// swiftlint:enable large_tuple
