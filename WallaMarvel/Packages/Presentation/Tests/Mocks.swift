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
import SwiftUI

@testable import Presentation

public class CoordinatorProtocolMock: CoordinatorProtocol {
    public init() {}

    public var path: NavigationPath {
        get { underlyingPath }
        set(value) { underlyingPath = value }
    }

    public var underlyingPath: NavigationPath!
    public var sheet: Sheet?
    public var fullScreenCover: FullScreenCover?

    // MARK: - push

    public var pushPageCallsCount = 0
    public var pushPageCalled: Bool {
        pushPageCallsCount > 0
    }

    public var pushPageReceivedPage: AppPages?
    public var pushPageReceivedInvocations: [AppPages] = []
    public var pushPageClosure: ((AppPages) -> Void)?

    public func push(page: AppPages) {
        pushPageCallsCount += 1
        pushPageReceivedPage = page
        pushPageReceivedInvocations.append(page)
        pushPageClosure?(page)
    }

    // MARK: - pop

    public var popCallsCount = 0
    public var popCalled: Bool {
        popCallsCount > 0
    }

    public var popClosure: (() -> Void)?

    public func pop() {
        popCallsCount += 1
        popClosure?()
    }

    // MARK: - popToRoot

    public var popToRootCallsCount = 0
    public var popToRootCalled: Bool {
        popToRootCallsCount > 0
    }

    public var popToRootClosure: (() -> Void)?

    public func popToRoot() {
        popToRootCallsCount += 1
        popToRootClosure?()
    }

    // MARK: - presentSheet

    public var presentSheetCallsCount = 0
    public var presentSheetCalled: Bool {
        presentSheetCallsCount > 0
    }

    public var presentSheetReceivedSheet: Sheet?
    public var presentSheetReceivedInvocations: [Sheet] = []
    public var presentSheetClosure: ((Sheet) -> Void)?

    public func presentSheet(_ sheet: Sheet) {
        presentSheetCallsCount += 1
        presentSheetReceivedSheet = sheet
        presentSheetReceivedInvocations.append(sheet)
        presentSheetClosure?(sheet)
    }

    // MARK: - presentFullScreenCover

    public var presentFullScreenCoverCallsCount = 0
    public var presentFullScreenCoverCalled: Bool {
        presentFullScreenCoverCallsCount > 0
    }

    public var presentFullScreenCoverReceivedCover: FullScreenCover?
    public var presentFullScreenCoverReceivedInvocations: [FullScreenCover] = []
    public var presentFullScreenCoverClosure: ((FullScreenCover) -> Void)?

    public func presentFullScreenCover(_ cover: FullScreenCover) {
        presentFullScreenCoverCallsCount += 1
        presentFullScreenCoverReceivedCover = cover
        presentFullScreenCoverReceivedInvocations.append(cover)
        presentFullScreenCoverClosure?(cover)
    }

    // MARK: - dismissSheet

    public var dismissSheetCallsCount = 0
    public var dismissSheetCalled: Bool {
        dismissSheetCallsCount > 0
    }

    public var dismissSheetClosure: (() -> Void)?

    public func dismissSheet() {
        dismissSheetCallsCount += 1
        dismissSheetClosure?()
    }

    // MARK: - dismissCover

    public var dismissCoverCallsCount = 0
    public var dismissCoverCalled: Bool {
        dismissCoverCallsCount > 0
    }

    public var dismissCoverClosure: (() -> Void)?

    public func dismissCover() {
        dismissCoverCallsCount += 1
        dismissCoverClosure?()
    }

    // MARK: - build

    public var buildPageCallsCount = 0
    public var buildPageCalled: Bool {
        buildPageCallsCount > 0
    }

    public var buildPageReceivedPage: AppPages?
    public var buildPageReceivedInvocations: [AppPages] = []
    public var buildPageReturnValue: (any View)!
    public var buildPageClosure: ((AppPages) -> any View)?

    public func build(page: AppPages) -> any View {
        buildPageCallsCount += 1
        buildPageReceivedPage = page
        buildPageReceivedInvocations.append(page)
        if let buildPageClosure {
            return buildPageClosure(page)
        } else {
            return buildPageReturnValue
        }
    }

    // MARK: - buildSheet

    public var buildSheetSheetCallsCount = 0
    public var buildSheetSheetCalled: Bool {
        buildSheetSheetCallsCount > 0
    }

    public var buildSheetSheetReceivedSheet: Sheet?
    public var buildSheetSheetReceivedInvocations: [Sheet] = []
    public var buildSheetSheetReturnValue: (any View)!
    public var buildSheetSheetClosure: ((Sheet) -> any View)?

    public func buildSheet(sheet: Sheet) -> any View {
        buildSheetSheetCallsCount += 1
        buildSheetSheetReceivedSheet = sheet
        buildSheetSheetReceivedInvocations.append(sheet)
        if let buildSheetSheetClosure {
            return buildSheetSheetClosure(sheet)
        } else {
            return buildSheetSheetReturnValue
        }
    }

    // MARK: - buildCover

    public var buildCoverCoverCallsCount = 0
    public var buildCoverCoverCalled: Bool {
        buildCoverCoverCallsCount > 0
    }

    public var buildCoverCoverReceivedCover: FullScreenCover?
    public var buildCoverCoverReceivedInvocations: [FullScreenCover] = []
    public var buildCoverCoverReturnValue: (any View)!
    public var buildCoverCoverClosure: ((FullScreenCover) -> any View)?

    public func buildCover(cover: FullScreenCover) -> any View {
        buildCoverCoverCallsCount += 1
        buildCoverCoverReceivedCover = cover
        buildCoverCoverReceivedInvocations.append(cover)
        if let buildCoverCoverClosure {
            return buildCoverCoverClosure(cover)
        } else {
            return buildCoverCoverReturnValue
        }
    }
}

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
