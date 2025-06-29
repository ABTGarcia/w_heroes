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

@testable import Presentation

public class GetHeroDetailUseCaseProtocolMock: GetHeroDetailUseCaseProtocol, @unchecked Sendable {
    public init() {}

    // MARK: - invoke

    public var invokeDetailUrlThrowableError: (any Error)?
    public var invokeDetailUrlCallsCount = 0
    public var invokeDetailUrlCalled: Bool {
        invokeDetailUrlCallsCount > 0
    }

    public var invokeDetailUrlReceivedDetailUrl: String?
    public var invokeDetailUrlReceivedInvocations: [String] = []
    public var invokeDetailUrlReturnValue: HeroDetail!
    public var invokeDetailUrlClosure: ((String) async throws -> HeroDetail)?

    public func invoke(detailUrl: String) async throws -> HeroDetail {
        invokeDetailUrlCallsCount += 1
        invokeDetailUrlReceivedDetailUrl = detailUrl
        invokeDetailUrlReceivedInvocations.append(detailUrl)
        if let error = invokeDetailUrlThrowableError {
            throw error
        }
        if let invokeDetailUrlClosure {
            return try await invokeDetailUrlClosure(detailUrl)
        } else {
            return invokeDetailUrlReturnValue
        }
    }
}

public class GetHeroesListUseCaseProtocolMock: GetHeroesListUseCaseProtocol, @unchecked Sendable {
    public init() {}

    // MARK: - invoke

    public var invokeLastIdThrowableError: (any Error)?
    public var invokeLastIdCallsCount = 0
    public var invokeLastIdCalled: Bool {
        invokeLastIdCallsCount > 0
    }

    public var invokeLastIdReceivedLastId: String?
    public var invokeLastIdReceivedInvocations: [String?] = []
    public var invokeLastIdReturnValue: HeroesList!
    public var invokeLastIdClosure: ((String?) async throws -> HeroesList)?

    public func invoke(lastId: String?) async throws -> HeroesList {
        invokeLastIdCallsCount += 1
        invokeLastIdReceivedLastId = lastId
        invokeLastIdReceivedInvocations.append(lastId)
        if let error = invokeLastIdThrowableError {
            throw error
        }
        if let invokeLastIdClosure {
            return try await invokeLastIdClosure(lastId)
        } else {
            return invokeLastIdReturnValue
        }
    }
}

public class HeroDetailViewModelProtocolMock: HeroDetailViewModelProtocol {
    public init() {}

    public var state: HeroDetailState {
        get { underlyingState }
        set(value) { underlyingState = value }
    }

    public var underlyingState: HeroDetailState!

    // MARK: - process

    public var processCallsCount = 0
    public var processCalled: Bool {
        processCallsCount > 0
    }

    public var processReceivedEvent: HeroDetailEvent?
    public var processReceivedInvocations: [HeroDetailEvent] = []
    public var processClosure: ((HeroDetailEvent) async -> Void)?

    public func process(_ event: HeroDetailEvent) async {
        processCallsCount += 1
        processReceivedEvent = event
        processReceivedInvocations.append(event)
        await processClosure?(event)
    }
}

public class HeroesListViewModelProtocolMock: HeroesListViewModelProtocol {
    public init() {}

    public var state: HeroesListState {
        get { underlyingState }
        set(value) { underlyingState = value }
    }

    public var underlyingState: HeroesListState!

    // MARK: - process

    public var processCallsCount = 0
    public var processCalled: Bool {
        processCallsCount > 0
    }

    public var processReceivedEvent: HeroesListEvent?
    public var processReceivedInvocations: [HeroesListEvent] = []
    public var processClosure: ((HeroesListEvent) async -> Void)?

    public func process(_ event: HeroesListEvent) async {
        processCallsCount += 1
        processReceivedEvent = event
        processReceivedInvocations.append(event)
        await processClosure?(event)
    }
}

public class SearchHeroByNameUseCaseProtocolMock: SearchHeroByNameUseCaseProtocol, @unchecked Sendable {
    public init() {}

    // MARK: - invoke

    public var invokeThrowableError: (any Error)?
    public var invokeCallsCount = 0
    public var invokeCalled: Bool {
        invokeCallsCount > 0
    }

    public var invokeReceivedName: String?
    public var invokeReceivedInvocations: [String] = []
    public var invokeReturnValue: [Hero]?
    public var invokeClosure: ((String) async throws -> [Hero]?)?

    public func invoke(_ name: String) async throws -> [Hero]? {
        invokeCallsCount += 1
        invokeReceivedName = name
        invokeReceivedInvocations.append(name)
        if let error = invokeThrowableError {
            throw error
        }
        if let invokeClosure {
            return try await invokeClosure(name)
        } else {
            return invokeReturnValue
        }
    }
}

// swiftlint:enable line_length
// swiftlint:enable variable_name
// swiftlint:enable superfluous_disable_command
// swiftlint:enable force_cast
// swiftlint:enable large_tuple
