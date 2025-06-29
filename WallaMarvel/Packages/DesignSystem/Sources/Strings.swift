import Foundation

public enum WMString {
    // Ideally I would use SwiftGen to auto generate it, but the PR with support for String catalogs is still open
    // https://github.com/SwiftGen/SwiftGen/pull/1124
    public static let genericErrorTitle = String(localized: "generic_error_title", bundle: .module)
    public static let genericErrorMessage = String(localized: "generic_error_message", bundle: .module)
    public static let genericErrorRetryButton = String(localized: "generic_error_retry_button", bundle: .module)

    public static let heroDetailSectionEnemies = String(localized: "hero_detail_section_enemies", bundle: .module)
    public static let heroDetailSectionCreators = String(localized: "hero_detail_section_creators", bundle: .module)
    public static let heroDetailSectionFriends = String(localized: "hero_detail_section_friends", bundle: .module)
    public static let heroDetailRealName = String(localized: "hero_detail_real_name", bundle: .module)
    public static let heroDetailSearch = String(localized: "hero_detail_search", bundle: .module)

    public static let searchHeroesEmpty = String(localized: "search_heroes_empty", bundle: .module)
    public static let searchHeroesError = String(localized: "search_heroes_error", bundle: .module)

    public static let loading = String(localized: "loading", bundle: .module)
}
