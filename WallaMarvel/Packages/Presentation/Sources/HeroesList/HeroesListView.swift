import DesignSystem
import Domain
import SwiftUI

public struct HeroesListView<ViewModel: HeroesListViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject private var coordinator: Coordinator

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
                LazyVStack(alignment: .leading, spacing: .spacingS) {
                    ForEach(data.list) { hero in
                        HeroCardView(data: hero)
                            .listRowSeparatorTint(.wmMain)
                            .listRowSeparator(.automatic)
                            .onAppear {
                                Task {
                                    await viewModel.process(.appearedHeroId(hero.id))
                                }
                            }
                            .padding(.horizontal, .spacingL)
                            .onTapGesture {
                                coordinator.push(page: .heroDetail(hero.apiDetailUrl))
                            }
                    }

                    if data.isLoading {
                        HStack {
                            Spacer()
                            LoadingView()
                            Spacer()
                        }
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
                Hero(id: "1", image: "https://picsum.photos/100", name: "E", description: "T", apiDetailUrl: "A"),
                Hero(id: "2", image: "A", name: "B", description: "C", apiDetailUrl: "A")
            ], isLoading: false
        ))

        func process(_: HeroesListEvent) async {}
    }
    let viewModel = HeroesListViewModelPreview()

    return HeroesListView(viewModel: viewModel)
}
