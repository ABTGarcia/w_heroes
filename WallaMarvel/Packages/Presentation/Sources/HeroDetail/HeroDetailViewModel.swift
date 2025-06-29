import DesignSystem
import Domain
import FactoryKit
import Foundation

public enum HeroDetailEvent: Equatable, Sendable {
    case loadData
}

public enum HeroDetailState: Equatable, Sendable {
    case loaded(HeroDetailViewData)
    case loading
    case error
}

// sourcery: AutoMockable
@MainActor
public protocol HeroDetailViewModelProtocol: ObservableObject {
    var state: HeroDetailState { get }
    func process(_ event: HeroDetailEvent) async
}

// sourcery: AutoMockable
@MainActor
public final class HeroDetailViewModel: HeroDetailViewModelProtocol {
    @Published public var state: HeroDetailState

    private let container: Container
    private var getHeroDetailUseCase: GetHeroDetailUseCaseProtocol
    private let detailUrl: String

    public init(detailUrl: String, container: Container = .shared) {
        self.detailUrl = detailUrl
        self.container = container
        guard let getHeroDetailUseCase = container.getHeroDetailUseCase() else {
            preconditionFailure("UseCase not found")
        }
        self.getHeroDetailUseCase = getHeroDetailUseCase
        state = .loading
    }

    public func process(_ event: HeroDetailEvent) async {
        switch event {
        case .loadData:
            do {
                let response = try await getHeroDetailUseCase.invoke(detailUrl: detailUrl)
                state = .loaded(HeroDetailViewData(
                    name: response.name,
                    realName: response.realName,
                    image: response.image,
                    deck: response.deck,
                    creators: response.creators,
                    enemies: response.enemies,
                    friends: response.friends
                ))
            } catch {
                state = .error
            }
        }
    }
}
