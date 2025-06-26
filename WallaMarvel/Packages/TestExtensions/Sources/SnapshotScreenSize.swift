import Foundation

public enum SnapshotScreenSize {
    case iPhone16Portrait
    case iPhoneSEPortrait
    case smallRectangle
    case custom(width: CGFloat, height: CGFloat)

    public var cgSize: CGSize {
        switch self {
        case .iPhone16Portrait: return CGSize(width: 393, height: 852)
        case .iPhoneSEPortrait: return CGSize(width: 320, height: 568)
        case .smallRectangle: return CGSize(width: 200, height: 150)
        case let .custom(width, height): return CGSize(width: width, height: height)
        }
    }

    public var sizeName: String {
        switch self {
        case .iPhone16Portrait: return "iPhone"
        case .iPhoneSEPortrait: return "iPhoneSEPortrait"
        case .smallRectangle: return "smallRectangle"
        case .custom: return "customSize"
        }
    }
}
