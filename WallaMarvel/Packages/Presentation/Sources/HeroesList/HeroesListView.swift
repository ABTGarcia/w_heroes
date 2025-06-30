import DesignSystem
import Domain
import SwiftUI

public struct HeroesListView<ViewModel: HeroesListViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject private var coordinator: Coordinator
    @State private var searchText = ""

    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        Task {
            await viewModel.process(.appeared)
        }
    }

    public var body: some View {
        switch viewModel.state {
        case let .loaded(data):
            VStack {
                SearchFieldView(searchText: $searchText) {
                    Task {
                        await viewModel.process(.tapClearResults)
                    }
                }
                .padding()
                .shadow(radius: 2)
                .onChange(of: searchText, initial: true) { prev, current in
                    guard prev != current else {
                        return
                    }
                    Task {
                        await viewModel.process(.searchTextChanged(searchText))
                    }
                }

                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: .spacingL),
                        GridItem(.flexible())
                    ]) {
                        ForEach(data.list) { hero in
                            HeroCardView(data: hero)
                                .onAppear {
                                    Task {
                                        await viewModel.process(.appearedHeroId(hero.id))
                                    }
                                }
                                .onTapGesture {
                                    coordinator.push(page: .heroDetail(hero.apiDetailUrl))
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
                                await viewModel.process(.tapListRetry)
                            }
                        }.background(Color.white)
                    }
                }
                .overlay(alignment: .top) {
                    if !data.searchList.isEmpty {
                        ScrollView {
                            LazyVStack(alignment: .leading) {
                                ForEach(data.searchList) { result in
                                    SearchResultsCardView(result: result)
                                        .onTapGesture {
                                            coordinator.push(page: .heroDetail(result.apiDetailUrl))
                                        }
                                        .accessibilityHint(String(localized: String.LocalizationValue(WMString.heroListAccNavigateDetail)))
                                        .padding()
                                }
                            }
                        }
                        .background(Color.white)
                    }
                }
            }
        case .loading:
            LoadingView()
        case .error:
            ErrorView {
                Task {
                    await viewModel.process(.tapMainRetry)
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
    let viewModel = HeroesListViewModelPreview()

    return HeroesListView(viewModel: viewModel)
}
