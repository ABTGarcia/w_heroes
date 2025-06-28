import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?

    func push(page: AppPages) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }

    func presentFullScreenCover(_ cover: FullScreenCover) {
        fullScreenCover = cover
    }

    func dismissSheet() {
        sheet = nil
    }

    func dismissCover() {
        fullScreenCover = nil
    }

    @MainActor @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .heroesList: HeroesListView(viewModel: HeroesListViewModel())
        case let .heroDetail(id):
            HeroDetailView()
        }
    }

    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .empty: EmptyView()
        }
    }

    @ViewBuilder
    func buildCover(cover: FullScreenCover) -> some View {
        switch cover {
        case .empty: EmptyView()
        }
    }
}
