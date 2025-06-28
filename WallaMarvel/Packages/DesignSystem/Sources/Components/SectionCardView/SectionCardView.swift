import SwiftUI

public struct SectionCardView: View {
    private let data: SectionCardViewData

    public init(data: SectionCardViewData) {
        self.data = data
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Label(title: {
                Text(data.name)
                    .font(.wmTitle)
            }, icon: {
                Image(systemName: data.systemImageName)
                    .foregroundColor(.wmMain)
            })
            .foregroundColor(.wmMainText)
            .padding(.bottom, .spacingXXS)

            ForEach(data.content, id: \.self) { item in
                Text("• \(item)")
                    .font(.wmDescription)
            }
        }
        .padding()
        .background(data.backgroundColor)
        .cornerRadius(15)
    }
}

#Preview {
    let data = SectionCardViewData(
        name: "Friends",
        systemImageName: "heart.fill",
        content: ["A", "B", "C", "D", "E"],
        backgroundColor: .wmDreamBackground
    )
    SectionCardView(data: data)
}
