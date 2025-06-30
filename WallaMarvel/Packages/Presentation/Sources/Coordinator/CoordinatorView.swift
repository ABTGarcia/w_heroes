import DesignSystem
import SwiftUI

public struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()

    public init() {}

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            AnyView(coordinator.build(page: .heroesList))
                .navigationDestination(for: AppPages.self) { page in
                    AnyView(coordinator.build(page: page))
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    AnyView(coordinator.buildSheet(sheet: sheet))
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    AnyView(coordinator.buildCover(cover: item))
                }
        }
        .environmentObject(coordinator)
        .tint(.wmMain)
    }
}
