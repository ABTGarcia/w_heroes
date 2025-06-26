import SwiftUI

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
                    HStack {
                        AsyncImage(url: URL(string: hero.image)) { image in
                            image.resizable()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            Image(systemName: "person.fill")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                        }
                        Text(hero.name)
                    }

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
                HeroeViewData(id: "1", image: "https://picsum.photos/100", name: "A"),
                HeroeViewData(id: "2", image: "https://picsum.photos/100", name: "B"),
                HeroeViewData(id: "3", image: "B", name: "C")
            ]))

        func process(_ event: HeroesListEvent) async {}
    }
    let viewModel = HeroesListViewModelPreview()

    return HeroesListView(viewModel: viewModel)
}
