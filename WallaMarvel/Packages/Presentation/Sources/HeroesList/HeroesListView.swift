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
            await viewModel.process(.loadData)
        }
    }

    public var body: some View {
        switch viewModel.state {
        case let .loaded(data):
            VStack {
                SearchFieldView(searchText: $searchText) {
                    Task {
                        await viewModel.process(.clearResults)
                    }
                }
                .padding()
                .shadow(radius: 2)
                .onChange(of: searchText, initial: true) { _, _ in
                    Task {
                        await viewModel.process(.search(searchText))
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
                    }
                }
                .overlay(alignment: .top) {
                    if !data.searchList.isEmpty {
                        ScrollView {
                            LazyVStack(alignment: .leading) {
                                ForEach(data.searchList) { result in
                                    SearchResultsCardView(result: result)
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
                    await viewModel.process(.loadData)
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
