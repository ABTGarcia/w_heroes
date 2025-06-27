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

    public var findAllThrowableError: (any Error)?
    public var findAllCallsCount = 0
    public var findAllCalled: Bool {
        return findAllCallsCount > 0
    }
    public var findAllReturnValue: HeroesList!
    public var findAllClosure: (() async throws -> HeroesList)?

    public func findAll() async throws -> HeroesList {
        findAllCallsCount += 1
        if let error = findAllThrowableError {
            throw error
        }
        if let findAllClosure = findAllClosure {
            return try await findAllClosure()
        } else {
            return findAllReturnValue
        }
    }

}

// swiftlint:enable line_length
// swiftlint:enable variable_name
// swiftlint:enable superfluous_disable_command
// swiftlint:enable force_cast
// swiftlint:enable large_tuple
