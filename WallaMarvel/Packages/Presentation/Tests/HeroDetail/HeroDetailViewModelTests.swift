import DesignSystem
import Domain
import FactoryKit
@testable import Presentation
import TestExtensions
import Testing

@MainActor
struct HeroDetailViewModelTests {
    private var sut: HeroDetailViewModel!
    private let container: Container
    private var getHeroDetailUseCaseProtocolMock = GetHeroDetailUseCaseProtocolMock()
    private let heroDetail = HeroDetail(
        name: "A",
        image: "B",
        creators: ["C"],
        friends: ["D"],
        enemies: ["E"]
    )

    init() {
        container = Container()
        setDependencies()
        sut = HeroDetailViewModel(detailUrl: "AAA", container: container)
    }

    @Test func initTests() async {
        // Then
        #expect(sut.state == .loading)
    }

    @Test func loadData() async {
        // Given
        let expected = HeroDetailViewData(
            name: heroDetail.name,
            realName: heroDetail.realName,
            image: heroDetail.image,
            deck: heroDetail.deck,
            creators: heroDetail.creators,
            enemies: heroDetail.enemies,
            friends: heroDetail.friends
        )
        getHeroDetailUseCaseProtocolMock.invokeDetailUrlReturnValue = heroDetail

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == .loaded(expected))
        #expect(getHeroDetailUseCaseProtocolMock.invokeDetailUrlReceivedDetailUrl == "AAA")
    }

    @Test func loadDataError() async {
        // Given
        getHeroDetailUseCaseProtocolMock.invokeDetailUrlThrowableError = TestError.genericError

        // When
        await sut.process(.loadData)

        // Then
        #expect(sut.state == .error)
        #expect(getHeroDetailUseCaseProtocolMock.invokeDetailUrlReceivedDetailUrl == "AAA")
    }

    private func setDependencies() {
        container.getHeroDetailUseCase.register { getHeroDetailUseCaseProtocolMock }
    }

    private enum TestError: Error {
        case genericError
    }
}
