import SwiftUI

public struct SearchFieldView: View {
    @Binding private var searchText: String
    private var clearButtonClosure: () -> Void

    public init(searchText: Binding<String>, clearButtonClosure: @escaping () -> Void) {
        _searchText = searchText
        self.clearButtonClosure = clearButtonClosure
    }

    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .accessibilityHidden(true)
            TextField(String(localized: String.LocalizationValue(WMString.heroDetailSearch)), text: $searchText)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.spacingXS)
                .background(Color.wmTranspBackground)
                .cornerRadius(8)
                .accessibilityHint(String(localized: String.LocalizationValue(WMString.searchHeroesAccTextfield)))

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    clearButtonClosure()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.wmMain)
                        .accessibilityHidden(true)
                })
                .accessibilityHint(String(localized: String.LocalizationValue(WMString.searchHeroesAccClear)))
            }
        }
    }
}

#Preview {
    SearchFieldView(searchText: Binding.constant("AAA"), clearButtonClosure: {})
}
