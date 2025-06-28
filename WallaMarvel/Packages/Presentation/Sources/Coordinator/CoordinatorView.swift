import SwiftUI

public struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()

    public init() {}

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .heroesList)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    coordinator.buildCover(cover: item)
                }
        }
        .environmentObject(coordinator)
    }
}
