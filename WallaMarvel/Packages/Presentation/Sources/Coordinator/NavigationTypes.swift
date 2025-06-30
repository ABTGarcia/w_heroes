public enum AppPages: Hashable {
    case heroesList
    case heroDetail(String)
}

public enum Sheet: String, Identifiable {
    public var id: String {
        rawValue
    }

    case empty
}

public enum FullScreenCover: String, Identifiable {
    public var id: String {
        rawValue
    }

    case empty
}
