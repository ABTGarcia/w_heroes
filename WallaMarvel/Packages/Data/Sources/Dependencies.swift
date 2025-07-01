import FactoryKit
import SwiftData

extension Container {
    var networkService: Factory<NetworkServiceProtocol> { self {
        NetworkService(environment: NetworkEnvironment(), logger: NetworkServiceLogger())
    } }

    var heroRemoteDatasource: Factory<HeroRemoteDatasourceProtocol> { self {
        HeroRemoteDatasource()
    } }

    var heroLocalDatasource: Factory<HeroLocalDatasourceProtocol> {
        self {
            guard let container = try? ModelContainer(
                for: HeroEntity.self,
                ImageEntity.self,
                HeroDetailEntity.self,
                RelatedSource.self
            ) else {
                preconditionFailure("ModelContainer not found")
            }
            return HeroLocalDatasource(context: ModelContext(container))
        }
    }
}
