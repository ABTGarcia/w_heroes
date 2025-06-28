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

@testable import Domain

public class HeroRepositoryProtocolMock: HeroRepositoryProtocol, @unchecked Sendable {
    public init() {}

    // MARK: - findAll

    public var findAllFromThrowableError: (any Error)?
    public var findAllFromCallsCount = 0
    public var findAllFromCalled: Bool {
        findAllFromCallsCount > 0
    }

    public var findAllFromReceivedPosition: Int?
    public var findAllFromReceivedInvocations: [Int] = []
    public var findAllFromReturnValue: HeroesList!
    public var findAllFromClosure: ((Int) async throws -> HeroesList)?

    public func findAll(from position: Int) async throws -> HeroesList {
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

    // MARK: - getDetail

    public var getDetailWithUrlThrowableError: (any Error)?
    public var getDetailWithUrlCallsCount = 0
    public var getDetailWithUrlCalled: Bool {
        getDetailWithUrlCallsCount > 0
    }

    public var getDetailWithUrlReceivedUrl: String?
    public var getDetailWithUrlReceivedInvocations: [String] = []
    public var getDetailWithUrlReturnValue: HeroDetail!
    public var getDetailWithUrlClosure: ((String) async throws -> HeroDetail)?

    public func getDetail(withUrl url: String) async throws -> HeroDetail {
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
}

// swiftlint:enable line_length
// swiftlint:enable variable_name
// swiftlint:enable superfluous_disable_command
// swiftlint:enable force_cast
// swiftlint:enable large_tuple
