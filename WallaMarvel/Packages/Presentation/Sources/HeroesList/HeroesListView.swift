import SwiftUI
import DesignSystem
import Domain

public struct HeroesListView<ViewModel: HeroesListViewModelProtocol>: View {
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
            List {
                ForEach(data.list) { hero in
                    HeroCardView(data: hero)
                        .listRowSeparatorTint(.wmMain)
                        .listRowSeparator(.automatic)
                }
            }
        case .loading:
            ProgressView()
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
            model: HeroesList(
                heroes: [
                    Hero(id: "1", image: "https://picsum.photos/100", name: "E", description: "T"),
                    Hero(id: "2", image: "A", name: "B", description: "C")
                ],
                pagination: Pagination(offset: 0, limit: 1, total: 2))))

        func process(_ event: HeroesListEvent) async {}
    }
    let viewModel = HeroesListViewModelPreview()

    return HeroesListView(viewModel: viewModel)
}
