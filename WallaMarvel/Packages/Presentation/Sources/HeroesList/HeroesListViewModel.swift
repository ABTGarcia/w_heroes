import FactoryKit
import Foundation

public enum HeroesListEvent: Equatable, Sendable {
    case loadData
}

public enum HeroesListState: Equatable, Sendable {
    case loaded(HeroesListViewData)
    case loading
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
            state = .loaded(HeroesListViewData(list: [
                HeroeViewData(id: "1", image: "https://picsum.photos/100", name: "A"),
                HeroeViewData(id: "2", image: "https://picsum.photos/100", name: "B"),
                HeroeViewData(id: "3", image: "", name: "C")
            ]))
        }
    }
}
