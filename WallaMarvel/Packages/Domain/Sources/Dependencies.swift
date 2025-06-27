import FactoryKit

public extension Container {
    var getHeroesListUseCase: Factory<GetHeroesListUseCaseProtocol?> { self { nil } }
    var heroRepository: Factory<HeroRepositoryProtocol?> { self { nil } }
}
