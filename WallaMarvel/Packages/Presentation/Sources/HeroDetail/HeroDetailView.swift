import DesignSystem
import Domain
import SwiftUI

public struct HeroDetailView<ViewModel: HeroDetailViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        Task {
            await viewModel.process(.loadData)
        }
    }

    public var body: some View {
        switch viewModel.state {
        case let .loaded(data):
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: data.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .accessibilityHidden(true)
                    } placeholder: {
                        WMImage.heroDetailPlaceholder
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .accessibilityHidden(true)
                    }
                    .clipped()
                    .cornerRadius(12)

                    HStack {
                        Label(title: {
                            Text(String(localized: String.LocalizationValue(WMString.heroDetailRealName)))
                                .font(.wmTitle)
                                .foregroundColor(.wmMainText)
                        }, icon: {
                            Image(systemName: "person.fill.questionmark")
                                .foregroundColor(.wmMain)
                                .accessibilityHidden(true)
                        })
                        Text(data.realName ?? data.name)
                            .font(.wmTitle)
                            .foregroundColor(.wmSecondaryText)
                    }

                    if let deck = data.deck {
                        Text(deck)
                            .font(.wmTitle)
                            .foregroundColor(.wmSecondaryText)
                    }

                    HStack(alignment: .top) {
                        SectionCardView(
                            data: SectionCardViewData(
                                name: String(localized: String.LocalizationValue(WMString.heroDetailSectionFriends)),
                                systemImageName: "heart.fill",
                                content: data.friends,
                                backgroundColor: .wmSweetBackground
                            ))

                        Spacer()

                        SectionCardView(
                            data: SectionCardViewData(
                                name: String(localized: String.LocalizationValue(WMString.heroDetailSectionEnemies)),
                                systemImageName: "heart.slash.fill",
                                content: data.enemies,
                                backgroundColor: .wmSadBackground
                            ))
                    }

                    SectionCardView(
                        data: SectionCardViewData(
                            name: String(localized: String.LocalizationValue(WMString.heroDetailSectionCreators)),
                            systemImageName: "pencil.and.scribble",
                            content: data.creators,
                            backgroundColor: .wmDreamBackground
                        ))
                }
                .padding()
                .navigationTitle(data.name)
                .navigationBarTitleDisplayMode(.large)
            }
        case .loading:
            LoadingView()
        case .error:
            ErrorView {
                Task {
                    await viewModel.process(.loadData)
                }
            }
        }
    }
}

#Preview {
    final class HeroDetailViewModelPreview: HeroDetailViewModelProtocol {
        func process(_: HeroDetailEvent) async {}

        var state: HeroDetailState = .loaded(
            HeroDetailViewData(
                name: "Dream Girl",
                realName: "AAA",
                image: "https://comicvine.gamespot.com/a/uploads/screen_medium/2/29837/2422799-dreamgirl_lsh_vol7_04.jpg",
                deck: "Nura Nal is from the planet Naltor, where all of the inhabitants have the ability to see into the ",
                creators: ["Edmond Hamilton", "John Forte"],
                enemies: ["Adam Orion", "Alex Luthor", "Anti-Monitor"],
                friends: ["Acrata", "Alex Danvers", "Ambassador Relnic"]
            ))

        func process(_: HeroesListEvent) async {}
    }
    let viewModel = HeroDetailViewModelPreview()

    return HeroDetailView(viewModel: viewModel)
}
