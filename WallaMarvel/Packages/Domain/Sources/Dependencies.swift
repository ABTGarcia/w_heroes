import FactoryKit

public extension Container {
    var getHeroesListUseCase: Factory<GetHeroesListUseCaseProtocol?> { self { nil } }
    var getHeroDetailUseCase: Factory<GetHeroDetailUseCaseProtocol?> { self { nil } }
    var searchHeroByNameUseCase: Factory<SearchHeroByNameUseCaseProtocol?> { self { nil } }
    var heroRepository: Factory<HeroRepositoryProtocol?> { self { nil } }
}
