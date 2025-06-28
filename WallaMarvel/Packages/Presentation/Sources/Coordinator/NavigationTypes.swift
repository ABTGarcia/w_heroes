enum AppPages: Hashable {
    case heroesList
    case heroDetail(String)
}

enum Sheet: String, Identifiable {
    var id: String {
        rawValue
    }

    case empty
}

enum FullScreenCover: String, Identifiable {
    var id: String {
        rawValue
    }

    case empty
}
