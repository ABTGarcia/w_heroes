import Kingfisher
import SwiftUI

public struct SearchResultsCardView: View {
    private var result: SearchResultsCardViewData

    public init(result: SearchResultsCardViewData) {
        self.result = result
    }

    public var body: some View {
        HStack {
            thumbnail
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .padding(.trailing, .spacingXXS)
                .accessibilityHidden(true)
            Text(result.name)
                .font(.wmTitle)
                .foregroundColor(.wmMainText)
            Spacer()
        }
    }

    private var thumbnail: some View {
        KFImage(URL(string: result.thumbnail))
            .placeholder {
                Image(.userPlaceholder)
                    .resizable()
            }
            .resizable()
    }
}

#Preview {
    SearchResultsCardView(
        result: SearchResultsCardViewData(id: "1", name: "AAA", thumbnail: "", apiDetailUrl: ""))
}
