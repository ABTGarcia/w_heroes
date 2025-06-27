import FactoryKit

extension Container {
    var networkService: Factory<NetworkServiceProtocol> { self {
        NetworkService(environment: NetworkEnvironment(), logger: NetworkServiceLogger())
    } }

    var heroDatasource: Factory<HeroDatasourceProtocol> { self {
        HeroDatasource()
    } }
}
