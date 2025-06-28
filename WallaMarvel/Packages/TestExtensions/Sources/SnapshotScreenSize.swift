import Foundation

public enum SnapshotScreenSize {
    case iPhone16Portrait
    case iPhoneSEPortrait
    case smallRectangle
    case custom(width: CGFloat, height: CGFloat)

    public var cgSize: CGSize {
        switch self {
        case .iPhone16Portrait: CGSize(width: 393, height: 852)
        case .iPhoneSEPortrait: CGSize(width: 320, height: 568)
        case .smallRectangle: CGSize(width: 200, height: 150)
        case let .custom(width, height): CGSize(width: width, height: height)
        }
    }

    public var sizeName: String {
        switch self {
        case .iPhone16Portrait: "iPhone"
        case .iPhoneSEPortrait: "iPhoneSEPortrait"
        case .smallRectangle: "smallRectangle"
        case .custom: "customSize"
        }
    }
}
