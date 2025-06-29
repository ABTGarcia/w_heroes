import SwiftUI

public struct HeroCardView: View {
    private let data: HeroCardViewData

    public init(data: HeroCardViewData) {
        self.data = data
    }

    public var body: some View {
        HStack(alignment: .top) {
            profileImage
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .padding(.trailing, .spacingXXS)
            VStack(alignment: .leading) {
                HStack {
                    Text(data.name)
                        .font(.wmTitle)
                    if let realName = data.realName {
                        Text("(\(realName))")
                            .font(.wmSmallText)
                    }
                }
                if let description = data.description {
                    Text(description)
                        .font(.wmDescription)
                        .lineLimit(3)
                        .truncationMode(.tail)
                }
            }
        }
    }

    @ViewBuilder
    private var profileImage: some View {
        AsyncImage(url: URL(string: data.image ?? "")) { image in
            image.resizable()
        } placeholder: {
            Image(.userPlaceholder)
                .resizable()
        }
    }
}

#Preview {
    let data = HeroCardViewData(
        id: "1",
        image: "AAAA",
        name: "DeadPool",
        realName: "AAA",
        description:
        """
        Lorem Ipsum is simply dummy
        text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standar
        """,
        apiDetailUrl: ""
    )
    HeroCardView(data: data)
}
