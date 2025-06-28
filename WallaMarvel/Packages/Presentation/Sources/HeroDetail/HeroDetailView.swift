import SwiftUI
import DesignSystem
import Domain

public struct HeroDetailView<ViewModel: HeroDetailViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject private var coordinator: Coordinator

    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        Task {
            await viewModel.process(.loadData)
        }
    }

    public var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    HeroDetailView(viewModel: HeroDetailViewModel(detailUrl: ""))
}
