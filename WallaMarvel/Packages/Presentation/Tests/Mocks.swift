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

@testable import Presentation

public class HeroesListViewModelProtocolMock: HeroesListViewModelProtocol {

    public init() {}

    public var state: HeroesListState {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    public var underlyingState: (HeroesListState)!

    // MARK: - process

    public var processCallsCount = 0
    public var processCalled: Bool {
        return processCallsCount > 0
    }
    public var processReceivedEvent: (HeroesListEvent)?
    public var processReceivedInvocations: [(HeroesListEvent)] = []
    public var processClosure: ((HeroesListEvent) async -> Void)?

    public func process(_ event: HeroesListEvent) async {
        processCallsCount += 1
        processReceivedEvent = event
        processReceivedInvocations.append(event)
        await processClosure?(event)
    }

}

// swiftlint:enable line_length
// swiftlint:enable variable_name
// swiftlint:enable superfluous_disable_command
// swiftlint:enable force_cast
// swiftlint:enable large_tuple
