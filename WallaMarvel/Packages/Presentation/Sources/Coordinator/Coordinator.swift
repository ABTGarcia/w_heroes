import Foundation
import SwiftUI

// sourcery: AutoMockable
@MainActor
public protocol CoordinatorProtocol {
    var path: NavigationPath { get }
    var sheet: Sheet? { get }
    var fullScreenCover: FullScreenCover? { get }
    func push(page: AppPages)
    func pop()
    func popToRoot()
    func presentSheet(_ sheet: Sheet)
    func presentFullScreenCover(_ cover: FullScreenCover)
    func dismissSheet()
    func dismissCover()
    func build(page: AppPages) -> any View
    func buildSheet(sheet: Sheet) -> any View
    func buildCover(cover: FullScreenCover) -> any View
}

@MainActor
public class Coordinator: CoordinatorProtocol, ObservableObject {
    @Published public var path: NavigationPath = .init()
    @Published public var sheet: Sheet?
    @Published public var fullScreenCover: FullScreenCover?

    public func push(page: AppPages) {
        path.append(page)
    }

    public func pop() {
        path.removeLast()
    }

    public func popToRoot() {
        path.removeLast(path.count)
    }

    public func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }

    public func presentFullScreenCover(_ cover: FullScreenCover) {
        fullScreenCover = cover
    }

    public func dismissSheet() {
        sheet = nil
    }

    public func dismissCover() {
        fullScreenCover = nil
    }

    @MainActor @ViewBuilder
    public func build(page: AppPages) -> any View {
        switch page {
        case .heroesList:
            HeroesListView(viewModel: HeroesListViewModel(coordinator: self))
        case let .heroDetail(detailUrl):
            HeroDetailView(viewModel: HeroDetailViewModel(detailUrl: detailUrl))
        }
    }

    @ViewBuilder
    public func buildSheet(sheet: Sheet) -> any View {
        switch sheet {
        case .empty: EmptyView()
        }
    }

    @ViewBuilder
    public func buildCover(cover: FullScreenCover) -> any View {
        switch cover {
        case .empty: EmptyView()
        }
    }
}
