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

class HeroLocalDatasourceProtocolMock: HeroLocalDatasourceProtocol {
    // MARK: - findAll

    var findAllFromLimitThrowableError: (any Error)?
    var findAllFromLimitCallsCount = 0
    var findAllFromLimitCalled: Bool {
        findAllFromLimitCallsCount > 0
    }

    var findAllFromLimitReceivedArguments: (position: Int, limit: Int)?
    var findAllFromLimitReceivedInvocations: [(position: Int, limit: Int)] = []
    var findAllFromLimitReturnValue: ListEntity<[HeroEntity]>!
    var findAllFromLimitClosure: ((Int, Int) async throws -> ListEntity<[HeroEntity]>)?

    func findAll(from position: Int, limit: Int) async throws -> ListEntity<[HeroEntity]> {
        findAllFromLimitCallsCount += 1
        findAllFromLimitReceivedArguments = (position: position, limit: limit)
        findAllFromLimitReceivedInvocations.append((position: position, limit: limit))
        if let error = findAllFromLimitThrowableError {
            throw error
        }
        if let findAllFromLimitClosure {
            return try await findAllFromLimitClosure(position, limit)
        } else {
            return findAllFromLimitReturnValue
        }
    }

    // MARK: - getDetail

    var getDetailWithUrlThrowableError: (any Error)?
    var getDetailWithUrlCallsCount = 0
    var getDetailWithUrlCalled: Bool {
        getDetailWithUrlCallsCount > 0
    }

    var getDetailWithUrlReceivedUrl: String?
    var getDetailWithUrlReceivedInvocations: [String] = []
    var getDetailWithUrlReturnValue: HeroDetailEntity!
    var getDetailWithUrlClosure: ((String) async throws -> HeroDetailEntity)?

    func getDetail(withUrl url: String) async throws -> HeroDetailEntity {
        getDetailWithUrlCallsCount += 1
        getDetailWithUrlReceivedUrl = url
        getDetailWithUrlReceivedInvocations.append(url)
        if let error = getDetailWithUrlThrowableError {
            throw error
        }
        if let getDetailWithUrlClosure {
            return try await getDetailWithUrlClosure(url)
        } else {
            return getDetailWithUrlReturnValue
        }
    }

    // MARK: - save

    var saveHeroesThrowableError: (any Error)?
    var saveHeroesCallsCount = 0
    var saveHeroesCalled: Bool {
        saveHeroesCallsCount > 0
    }

    var saveHeroesReceivedHeroes: [HeroEntity]?
    var saveHeroesReceivedInvocations: [[HeroEntity]] = []
    var saveHeroesClosure: (([HeroEntity]) async throws -> Void)?

    func save(heroes: [HeroEntity]) async throws {
        saveHeroesCallsCount += 1
        saveHeroesReceivedHeroes = heroes
        saveHeroesReceivedInvocations.append(heroes)
        if let error = saveHeroesThrowableError {
            throw error
        }
        try await saveHeroesClosure?(heroes)
    }

    // MARK: - save

    var saveHeroDetailThrowableError: (any Error)?
    var saveHeroDetailCallsCount = 0
    var saveHeroDetailCalled: Bool {
        saveHeroDetailCallsCount > 0
    }

    var saveHeroDetailReceivedHeroDetail: HeroDetailEntity?
    var saveHeroDetailReceivedInvocations: [HeroDetailEntity] = []
    var saveHeroDetailClosure: ((HeroDetailEntity) async throws -> Void)?

    func save(heroDetail: HeroDetailEntity) async throws {
        saveHeroDetailCallsCount += 1
        saveHeroDetailReceivedHeroDetail = heroDetail
        saveHeroDetailReceivedInvocations.append(heroDetail)
        if let error = saveHeroDetailThrowableError {
            throw error
        }
        try await saveHeroDetailClosure?(heroDetail)
    }
}

class HeroRemoteDatasourceProtocolMock: HeroRemoteDatasourceProtocol, @unchecked Sendable {
    // MARK: - findAll

    var findAllFromLimitThrowableError: (any Error)?
    var findAllFromLimitCallsCount = 0
    var findAllFromLimitCalled: Bool {
        findAllFromLimitCallsCount > 0
    }

    var findAllFromLimitReceivedArguments: (position: Int, limit: Int)?
    var findAllFromLimitReceivedInvocations: [(position: Int, limit: Int)] = []
    var findAllFromLimitReturnValue: ListEntity<[HeroEntity]>!
    var findAllFromLimitClosure: ((Int, Int) async throws -> ListEntity<[HeroEntity]>)?

    func findAll(from position: Int, limit: Int) async throws -> ListEntity<[HeroEntity]> {
        findAllFromLimitCallsCount += 1
        findAllFromLimitReceivedArguments = (position: position, limit: limit)
        findAllFromLimitReceivedInvocations.append((position: position, limit: limit))
        if let error = findAllFromLimitThrowableError {
            throw error
        }
        if let findAllFromLimitClosure {
            return try await findAllFromLimitClosure(position, limit)
        } else {
            return findAllFromLimitReturnValue
        }
    }

    // MARK: - getDetail

    var getDetailWithUrlThrowableError: (any Error)?
    var getDetailWithUrlCallsCount = 0
    var getDetailWithUrlCalled: Bool {
        getDetailWithUrlCallsCount > 0
    }

    var getDetailWithUrlReceivedUrl: String?
    var getDetailWithUrlReceivedInvocations: [String] = []
    var getDetailWithUrlReturnValue: HeroDetailEntity!
    var getDetailWithUrlClosure: ((String) async throws -> HeroDetailEntity)?

    func getDetail(withUrl url: String) async throws -> HeroDetailEntity {
        getDetailWithUrlCallsCount += 1
        getDetailWithUrlReceivedUrl = url
        getDetailWithUrlReceivedInvocations.append(url)
        if let error = getDetailWithUrlThrowableError {
            throw error
        }
        if let getDetailWithUrlClosure {
            return try await getDetailWithUrlClosure(url)
        } else {
            return getDetailWithUrlReturnValue
        }
    }

    // MARK: - searchByName

    var searchByNameThrowableError: (any Error)?
    var searchByNameCallsCount = 0
    var searchByNameCalled: Bool {
        searchByNameCallsCount > 0
    }

    var searchByNameReceivedName: String?
    var searchByNameReceivedInvocations: [String] = []
    var searchByNameReturnValue: [HeroEntity]!
    var searchByNameClosure: ((String) async throws -> [HeroEntity])?

    func searchByName(_ name: String) async throws -> [HeroEntity] {
        searchByNameCallsCount += 1
        searchByNameReceivedName = name
        searchByNameReceivedInvocations.append(name)
        if let error = searchByNameThrowableError {
            throw error
        }
        if let searchByNameClosure {
            return try await searchByNameClosure(name)
        } else {
            return searchByNameReturnValue
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
