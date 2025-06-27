import Domain
import FactoryKit
import Data

extension Container: @retroactive AutoRegistering {
    public func autoRegister() {
        getHeroesListUseCase.register { GetHeroesListUseCase() }
        heroRepository.register { HeroRepository() }
    }
}
