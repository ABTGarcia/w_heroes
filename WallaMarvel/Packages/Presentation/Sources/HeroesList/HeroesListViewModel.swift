import FactoryKit
import Foundation
import DesignSystem

public enum HeroesListEvent: Equatable, Sendable {
    case loadData
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

    public init(container: Container = .shared) {
        self.container = container
        state = .loading
    }

    public func process(_ event: HeroesListEvent) async {
        switch event {
        case .loadData:
            state = .loading
            do {
                guard let list = try await container.getHeroesListUseCase()?.invoke() else {
                    state = .error
                    return
                }
                state = .loaded(
                    HeroesListViewData(model: list)
                )
            } catch {
                state = .error
            }
        }
    }
}
