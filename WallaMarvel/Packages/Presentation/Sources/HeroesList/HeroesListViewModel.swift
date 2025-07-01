import DesignSystem
import Domain
import FactoryKit
import Foundation

public enum HeroesListEvent: Equatable, Sendable {
    case appeared
    case tapMainRetry
    case appearedHeroId(String)
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
    private var showResults = false

    public init(coordinator: CoordinatorProtocol, container: Container = .shared) {
        self.container = container
        guard let getHeroesListUseCase = container.getHeroesListUseCase() else {
            preconditionFailure("UseCase not found")
        }
        self.coordinator = coordinator
        self.getHeroesListUseCase = getHeroesListUseCase
        state = .loading
    }

    public func process(_ event: HeroesListEvent) async {
        switch event {
        case .appeared:
            await firstRetrieveData()
        case let .appearedHeroId(id):
            setLoadMore(true)
            await retrieveData(lastId: id)
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
}
