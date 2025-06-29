import DesignSystem
import Domain
import FactoryKit
import Foundation

public enum HeroesListEvent: Equatable, Sendable {
    case loadData
    case appearedHeroId(String)
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
    private var viewData = HeroesListViewData(heroes: [], isLoading: false)
    private var getHeroesListUseCase: GetHeroesListUseCaseProtocol

    public init(container: Container = .shared) {
        self.container = container
        guard let getHeroesListUseCase = container.getHeroesListUseCase() else {
            preconditionFailure("UseCase not found")
        }
        self.getHeroesListUseCase = getHeroesListUseCase
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
}
