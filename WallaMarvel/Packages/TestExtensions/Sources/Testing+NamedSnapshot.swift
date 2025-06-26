import Factory
import SnapshotTesting
import SwiftUI
import Testing

@MainActor
public func expectSnapshot<Value>(
    matching value: @autoclosure () throws -> Value,
    size: SnapshotScreenSize? = nil,
    record recording: Bool? = nil,
    timeout: TimeInterval = 5,
    fileID: StaticString = #fileID,
    file filePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line,
    column: UInt = #column,
    wait: Double = 0,
    container _: Container? = nil,
    skip: Bool = false,
    arguments: String? = nil
) where Value: View {
    guard !skip else { return }
    do {
        let view = try value()
        let hostingController = UIHostingController(rootView: view)
        let device = UIDevice.current.model
        let scale: String = {
            let scale = Float(UIScreen.main.scale)
            return String(Int(scale))
        }()

        var name = "\(size?.sizeName ?? device)-\(scale)"

        if let arguments {
            name = ".\(arguments)-\(name)"
        }

        hostingController.view.backgroundColor = .clear

        withSnapshotTesting(record: .failed) {
            assertSnapshot(
                of: hostingController,
                as: .wait(
                    for: wait,
                    on: .image(precision: 0.98, size: size?.cgSize ?? hostingController.view.intrinsicContentSize)
                ),
                named: name,
                record: recording,
                timeout: timeout,
                fileID: fileID,
                file: filePath,
                testName: testName,
                line: line,
                column: column
            )
        }
    } catch {
        Issue.record(
            error,
            sourceLocation: SourceLocation(
                fileID: fileID.description,
                filePath: filePath.description,
                line: Int(line),
                column: Int(column)
            )
        )
    }
}
