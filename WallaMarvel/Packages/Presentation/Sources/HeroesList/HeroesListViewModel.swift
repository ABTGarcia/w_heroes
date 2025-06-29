import DesignSystem
import Domain
import FactoryKit
import Foundation

public enum HeroesListEvent: Equatable, Sendable {
    case loadData
    case appearedHeroId(String)
    case search(String)
    case clearResults
}

public enum HeroesListState: Equatable, Sendable {
    case loaded(HeroesListViewData)
    case loading
    case error
}

// sourcery: AutoMockable
@MainActor
public protocol HeroesListViewModelProtocol: ObservableObject {
    var state: HeroesListState { get }
    func process(_ event: HeroesListEvent) async
}

// sourcery: AutoMockable
@MainActor
public final class HeroesListViewModel: HeroesListViewModelProtocol {
    @Published public var state: HeroesListState

    private let container: Container
    private var viewData = HeroesListViewData(heroes: [], isLoading: false, searchList: [])
    private var getHeroesListUseCase: GetHeroesListUseCaseProtocol
    private var searchHeroByNameUseCase: SearchHeroByNameUseCaseProtocol
    private var showResults = false

    public init(container: Container = .shared) {
        self.container = container
        guard
            let getHeroesListUseCase = container.getHeroesListUseCase(),
            let searchHeroByNameUseCase = container.searchHeroByNameUseCase()
        else {
            preconditionFailure("UseCase not found")
        }
        self.getHeroesListUseCase = getHeroesListUseCase
        self.searchHeroByNameUseCase = searchHeroByNameUseCase
        state = .loading
    }

    public func process(_ event: HeroesListEvent) async {
        switch event {
        case .loadData:
            state = .loading
            await retrieveData()
        case let .appearedHeroId(id):
            setLoadMore(true)
            await retrieveData(lastId: id)
        case let .search(name):
            await search(by: name)
        case .clearResults:
            clearResults()
        }
    }

    private func retrieveData(lastId: String? = nil) async {
        do {
            let newHeroesList = try await getHeroesListUseCase.invoke(lastId: lastId)

            if lastHeroReached(newHeroesList.pagination) {
                setLoadMore(false)
                return
            }

            if newHeroesList.heroes.isEmpty {
                return
            }

            viewData.appendHeroes(newHeroesList.heroes)
            setLoadMore(false)
        } catch {
            state = .error
        }
    }

    private func lastHeroReached(_ pagination: Pagination) -> Bool {
        pagination.limit + pagination.offset > pagination.total
    }

    private func setLoadMore(_ loading: Bool) {
        viewData.isLoading = loading
        state = .loaded(viewData)
    }

    private func clearResults() {
        showResults = false
        viewData.searchList = []
        state = .loaded(viewData)
    }

    private func search(by name: String) async {
        showResults = true
        do {
            guard let results = try await searchHeroByNameUseCase.invoke(name) else {
                return
            }

            guard showResults else {
                return
            }

            let foundHeroes = results.map { SearchResultsCardViewData(id: $0.id, name: $0.name, thumbnail: $0.thumbnail, apiDetailUrl: $0.apiDetailUrl) }
            viewData.searchList = foundHeroes.count > 0 ? foundHeroes : [SearchResultsCardViewData(id: "", name: WMString.searchHeroesEmpty, thumbnail: "", apiDetailUrl: "")]
            state = .loaded(viewData)
        } catch {
            viewData.searchList = [SearchResultsCardViewData(id: "", name: WMString.searchHeroesError, thumbnail: "", apiDetailUrl: "")]
            state = .loaded(viewData)
        }
    }
}
