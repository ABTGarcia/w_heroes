import Foundation

// sourcery: AutoMockable
public protocol NetworkEnvironmentProtocol: Sendable {
    var logMode: Bool { get }
}

public struct NetworkEnvironment: NetworkEnvironmentProtocol {
    public var logMode = true

    public init() {}
}
