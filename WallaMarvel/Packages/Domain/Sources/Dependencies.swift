import FactoryKit

public extension Container {
    var getHeroesListUseCase: Factory<GetHeroesListUseCaseProtocol?> { self { nil } }
}
