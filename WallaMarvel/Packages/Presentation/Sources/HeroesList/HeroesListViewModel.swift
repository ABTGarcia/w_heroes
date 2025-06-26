import FactoryKit
import Foundation
import DesignSystem

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
                HeroCardViewData(id: "1", image: "https://picsum.photos/100", name: "A", description: "orem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut"),
                HeroCardViewData(id: "2", image: "https://picsum.photos/100", name: "B", description: "orem ipsum dotempor incididunt ut labore"),
                HeroCardViewData(id: "3", image: "", name: "C", description: "")
            ]))
        }
    }
}
