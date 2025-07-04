import Kingfisher
import SwiftUI

public struct HeroCardView: View {
    private let data: HeroCardViewData

    public init(data: HeroCardViewData) {
        self.data = data
    }

    public var body: some View {
        VStack(alignment: .center) {
            profileImage
                .scaledToFit()
                .clipped()
                .accessibilityHidden(true)
            VStack(alignment: .center) {
                Text(data.name)
                    .foregroundStyle(Color.wmMainText)
                    .font(.wmTitle)

                if let realName = data.realName {
                    Text("(\(realName))")
                        .foregroundStyle(Color.wmMainText)
                        .font(.wmSmallText)
                }

                if let description = data.description {
                    Text(description)
                        .font(.wmDescription)
                        .foregroundStyle(Color.wmMainText)
                        .lineLimit(4)
                        .truncationMode(.tail)
                        .padding(.top, .spacingXS)
                }
            }
            .padding(.spacingXS)
        }
        .background(Color.wmDreamBackground)
        .cornerRadius(15)
    }

    @ViewBuilder
    private var profileImage: some View {
        KFImage(URL(string: data.image ?? ""))
            .placeholder {
                Image(.userPlaceholder)
                    .resizable()
            }
            .resizable()
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
        .frame(width: 150, height: 400)
}
