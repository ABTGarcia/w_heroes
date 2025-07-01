import DesignSystem
import Domain
import SwiftUI

public struct HeroesListView<
    HeroesListViewModel: HeroesListViewModelProtocol,
    SearchViewModel: SearchFieldViewModelProtocol
>: View {
    @StateObject private var heroesListViewModel: HeroesListViewModel
    @StateObject private var searchViewModel: SearchViewModel
    @State private var searchText = ""

    public init(heroesListViewModel: HeroesListViewModel, searchViewModel: SearchViewModel) {
        _heroesListViewModel = StateObject(wrappedValue: heroesListViewModel)
        _searchViewModel = StateObject(wrappedValue: searchViewModel)
        Task {
            await heroesListViewModel.process(.appeared)
        }
    }

    public var body: some View {
        switch heroesListViewModel.state {
        case let .loaded(data):
            ZStack(alignment: .top) {
                SearchFieldView(searchText: $searchText, viewModel: searchViewModel) { apiDetailUrl in
                    Task {
                        await heroesListViewModel.process(.tapHeroCell(apiDetailUrl))
                    }
                }
                .padding()
                .zIndex(1)

                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: .spacingL),
                        GridItem(.flexible())
                    ]) {
                        ForEach(data.list) { hero in
                            HeroCardView(data: hero)
                                .onAppear {
                                    Task {
                                        await heroesListViewModel.process(.appearedHeroId(hero.id))
                                    }
                                }
                                .onTapGesture {
                                    Task {
                                        await heroesListViewModel.process(.tapHeroCell(hero.apiDetailUrl))
                                    }
                                }
                                .accessibilityHint(String(localized: String.LocalizationValue(WMString.heroListAccNavigateDetail)))
                                .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                    .padding()
                    if data.isLoading {
                        HStack {
                            Spacer()
                            LoadingView()
                            Spacer()
                        }
                    } else if data.hasError {
                        ErrorView {
                            Task {
                                await heroesListViewModel.process(.tapListRetry)
                            }
                        }.background(Color.white)
                    }
                }
                .padding(.top, .spacingXXL)
            }
        case .loading:
            LoadingView()
        case .error:
            ErrorView {
                Task {
                    await heroesListViewModel.process(.tapMainRetry)
                }
            }
        }
    }
}

#Preview {
    final class HeroesListViewModelPreview: HeroesListViewModelProtocol {
        var state: HeroesListState = .loaded(HeroesListViewData(
            heroes: [
                Hero(id: "1", image: "https://picsum.photos/100", thumbnail: "", name: "E", realName: "AA", description: "T", apiDetailUrl: "A")
            ], isLoading: false, searchList: []
        ))

        func process(_: HeroesListEvent) async {}
    }
    let heroesListViewModel = HeroesListViewModelPreview()

    final class SearchFieldViewModelPreview: SearchFieldViewModelProtocol {
        var state: DesignSystem.SearchFieldViewState = .loading

        func process(_: DesignSystem.SearchFieldViewEvent) async {}
    }
    let searchViewModel = SearchFieldViewModelPreview()

    return HeroesListView(heroesListViewModel: heroesListViewModel, searchViewModel: searchViewModel)
}
