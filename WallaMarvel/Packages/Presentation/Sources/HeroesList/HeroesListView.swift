import SwiftUI
import DesignSystem

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
        }
    }
}

#Preview {
    final class HeroesListViewModelPreview: HeroesListViewModelProtocol {
        var state: HeroesListState = .loaded(
            HeroesListViewData(list: [
                HeroCardViewData(id: "1", image: "https://picsum.photos/100", name: "A", description: "orem ipsum dolor sit amet, consectetelit, sed do eiusmod tempor incididunt ut labore"),
                HeroCardViewData(id: "2", image: "https://picsum.photos/100", name: "B", description: "orem ipsum dotempor incididunt ut labore"),
                HeroCardViewData(id: "3", image: "", name: "C", description: "")
            ]))

        func process(_ event: HeroesListEvent) async {}
    }
    let viewModel = HeroesListViewModelPreview()

    return HeroesListView(viewModel: viewModel)
}
