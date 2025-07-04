import Data
import Domain
import FactoryKit

extension Container: @retroactive AutoRegistering {
    public func autoRegister() {
        getHeroesListUseCase.register { GetHeroesListUseCase() }
        getHeroDetailUseCase.register { GetHeroDetailUseCase() }
        searchHeroByNameUseCase.register { SearchHeroByNameUseCase() }

        heroRepository.register { HeroRepository() }
    }
}
