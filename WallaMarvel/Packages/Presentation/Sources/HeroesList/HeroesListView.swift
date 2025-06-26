import SwiftUI

public struct HeroesListView: View {
    public init() {}
    public var body: some View {
        List {
            Text("Heroes")
        }
    }
}

#Preview {
    return HeroesListView()
}
