public enum NetworkError: Error, Equatable {
    case decodingError
    case httpError(Int)
    case invalidURL
    case unknown
}
