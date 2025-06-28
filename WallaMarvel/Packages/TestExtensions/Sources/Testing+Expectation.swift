import Foundation
import Testing

public actor Expectation {
    public let name: String
    private(set) var fulfilled: Bool = false
    private(set) var count: Int = 0

    init(name: String) {
        self.name = name
    }

    public func fulfill() {
        fulfilled = true
        count += 1
    }

    public func wait(
        timeout: TimeInterval = 10,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) async throws {
        let timeout = ContinuousClock.now + .seconds(timeout)
        var waiting: Bool = !fulfilled
        while waiting {
            try await Task.sleep(nanoseconds: 1_000_000)
            if !fulfilled, timeout < .now {
                waiting = false
                Issue.record("Expecation Timeout: \(name)", sourceLocation: sourceLocation)
            } else {
                waiting = !fulfilled
            }
        }
    }
}

public func expectation(name: String) -> Expectation {
    .init(name: name)
}

extension Collection<Expectation> {
    private var pendingExpectations: [Expectation] {
        get async { await asyncCompactMap { await $0.fulfilled ? nil : $0 } }
    }

    public func wait(
        timeout: TimeInterval = 10,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) async throws {
        let timeout = ContinuousClock.now + .seconds(timeout)
        var waiting: [Expectation] = await pendingExpectations
        while waiting.count > 0 {
            try await Task.sleep(nanoseconds: 1_000_000)
            if timeout < .now {
                if waiting.count == 1 {
                    Issue.record(
                        "Expectation Timeout: \(waiting.first!.name)",
                        sourceLocation: sourceLocation
                    )
                } else {
                    Issue.record(
                        "Expectations Timeout: \(waiting.map(\.name).joined(separator: ", "))",
                        sourceLocation: sourceLocation
                    )
                }
                waiting = []
            } else {
                waiting = await pendingExpectations
            }
        }
    }
}

extension Sequence {
    func asyncCompactMap<T>(_ transform: (Element) async -> T?) async -> [T] {
        var values = [T]()
        for element in self {
            if let transform = await transform(element) {
                values.append(transform)
            }
        }
        return values
    }
}
