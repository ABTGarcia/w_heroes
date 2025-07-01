import Domain
import FactoryKit
import Foundation

public enum SearchFieldViewEvent: Equatable, Sendable {
    case searchTextChanged(String)
    case tapClearResults
}

public enum SearchFieldViewState: Equatable, Sendable {
    case loading
    case error
    case loaded([SearchResultsCardViewData])
    case noResults
    case hidden
}

// sourcery: AutoMockable
@MainActor
public protocol SearchFieldViewModelProtocol: ObservableObject {
    var state: SearchFieldViewState { get }
    func process(_ event: SearchFieldViewEvent) async
}

// sourcery: AutoMockable
@MainActor
public final class SearchFieldViewModel: SearchFieldViewModelProtocol {
    @Published public var state: SearchFieldViewState
    private let container: Container
    private var searchHeroByNameUseCase: SearchHeroByNameUseCaseProtocol

    public init(container: Container = .shared) {
        guard let searchHeroByNameUseCase = container.searchHeroByNameUseCase()
        else {
            preconditionFailure("UseCase not found")
        }
        self.searchHeroByNameUseCase = searchHeroByNameUseCase
        self.container = container
        state = .hidden
    }

    public func process(_ event: SearchFieldViewEvent) async {
        switch event {
        case let .searchTextChanged(text):
            await search(by: text)
        case .tapClearResults:
            clearResults()
        }
    }

    private func search(by name: String) async {
        guard !name.isEmpty else {
            clearResults()
            return
        }
        do {
            state = .loading
            guard let results = try await searchHeroByNameUseCase.invoke(name) else {
                state = .hidden
                return
            }

            let foundHeroes = results.map { SearchResultsCardViewData(id: $0.id, name: $0.name, thumbnail: $0.thumbnail, apiDetailUrl: $0.apiDetailUrl) }

            state = foundHeroes.count > 0 ? .loaded(foundHeroes) : .noResults
        } catch {
            state = .error
        }
    }

    private func clearResults() {
        state = .hidden
    }
}
