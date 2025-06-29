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
            Text(result.name)
                .font(.wmTitle)
                .foregroundColor(.wmMainText)
        }
    }

    private var thumbnail: some View {
        AsyncImage(url: URL(string: result.thumbnail)) { image in
            image.resizable()
        } placeholder: {
            Image(.userPlaceholder)
                .resizable()
        }
    }
}

#Preview {
    SearchResultsCardView(
        result: SearchResultsCardViewData(id: "1", name: "AAA", thumbnail: "", apiDetailUrl: ""))
}
