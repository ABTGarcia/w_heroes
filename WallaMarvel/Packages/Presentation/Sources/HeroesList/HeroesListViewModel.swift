import DesignSystem
import Domain
import FactoryKit
import Foundation

public enum HeroesListEvent: Equatable, Sendable {
    case appeared
    case tapMainRetry
    case appearedHeroId(String)
    case searchTextChanged(String)
    case tapClearResults
    case tapListRetry
    case tapHeroCell(String)
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

    private let coordinator: CoordinatorProtocol
    private let container: Container
    private var viewData = HeroesListViewData(heroes: [], isLoading: false, searchList: [])
    private var getHeroesListUseCase: GetHeroesListUseCaseProtocol
    private var searchHeroByNameUseCase: SearchHeroByNameUseCaseProtocol
    private var showResults = false

    public init(coordinator: CoordinatorProtocol, container: Container = .shared) {
        self.container = container
        guard
            let getHeroesListUseCase = container.getHeroesListUseCase(),
            let searchHeroByNameUseCase = container.searchHeroByNameUseCase()
        else {
            preconditionFailure("UseCase not found")
        }
        self.coordinator = coordinator
        self.getHeroesListUseCase = getHeroesListUseCase
        self.searchHeroByNameUseCase = searchHeroByNameUseCase
        state = .loading
    }

    public func process(_ event: HeroesListEvent) async {
        switch event {
        case .appeared:
            await firstRetrieveData()
        case let .appearedHeroId(id):
            setLoadMore(true)
            await retrieveData(lastId: id)
        case let .searchTextChanged(name):
            await search(by: name)
        case .tapClearResults:
            clearResults()
        case .tapMainRetry:
            await firstRetrieveData()
        case .tapListRetry:
            setLoadMore(true)
            await retrieveData(lastId: viewData.list.last?.id)
        case let .tapHeroCell(apiDetailUrl):
            navigateDetail(apiDetailUrl)
        }
    }

    private func navigateDetail(_ url: String) {
        guard !url.isEmpty else {
            return
        }
        coordinator.push(page: .heroDetail(url))
    }

    private func firstRetrieveData() async {
        state = .loading
        await retrieveData()
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
            if viewData.list.isEmpty {
                state = .error
            } else {
                setListError(true)
            }
        }
    }

    private func lastHeroReached(_ pagination: Pagination) -> Bool {
        pagination.limit + pagination.offset > pagination.total
    }

    private func setLoadMore(_ loading: Bool) {
        viewData.isLoading = loading
        viewData.hasError = false
        state = .loaded(viewData)
    }

    private func setListError(_ error: Bool) {
        viewData.hasError = error
        viewData.isLoading = false
        state = .loaded(viewData)
    }

    private func clearResults() {
        showResults = false
        viewData.searchList = []
        state = .loaded(viewData)
    }

    private func search(by name: String) async {
        guard !name.isEmpty else {
            clearResults()
            return
        }
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
