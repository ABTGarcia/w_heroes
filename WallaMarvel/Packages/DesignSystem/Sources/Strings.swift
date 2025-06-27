import Foundation

public struct WMString {
    // Ideally I would use SwiftGen to auto generate it, but the PR with support for String catalogs is still open
    // https://github.com/SwiftGen/SwiftGen/pull/1124
    public static let genericErrorTitle = String(localized: "generic_error_title", bundle: .module)
    public static let genericErrorMessage = String(localized: "generic_error_message", bundle: .module)
    public static let genericErrorRetryButton = String(localized: "generic_error_retry button", bundle: .module)
}
