import Domain
import FactoryKit

extension Container: @retroactive AutoRegistering {
    public func autoRegister() {
        getHeroesListUseCase.register { GetHeroesListUseCase() }
    }
}
