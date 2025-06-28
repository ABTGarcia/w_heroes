import Foundation
import SwiftUI

public struct SectionCardViewData: Equatable, Sendable {
    public let name: String
    public let systemImageName: String
    public let content: [String]
    public let backgroundColor: Color

    public init(name: String, systemImageName: String, content: [String], backgroundColor: Color) {
        self.name = name
        self.systemImageName = systemImageName
        self.content = content
        self.backgroundColor = backgroundColor
    }
}
