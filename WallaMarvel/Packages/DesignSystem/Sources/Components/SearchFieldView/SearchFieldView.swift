import SwiftUI

public struct SearchFieldView<ViewModel: SearchFieldViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @Binding private var searchText: String
    private let tapClosure: (String) -> Void

    public init(searchText: Binding<String>, viewModel: ViewModel, tapClosure: @escaping (String) -> Void) {
        _searchText = searchText
        self.tapClosure = tapClosure
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack {
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
                        Task {
                            await viewModel.process(.tapClearResults)
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.wmMain)
                            .accessibilityHidden(true)
                    })
                    .accessibilityHint(String(localized: String.LocalizationValue(WMString.searchHeroesAccClear)))
                }
            }
            .onChange(of: searchText, initial: true) { prev, current in
                guard prev != current else {
                    return
                }
                Task {
                    await viewModel.process(.searchTextChanged(searchText))
                }
            }
            switch viewModel.state {
            case let .loaded(data):
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(data) { result in
                            SearchResultsCardView(result: result)
                                .background(Color.wmTranspBackground)
                                .onTapGesture {
                                    tapClosure(result.apiDetailUrl)
                                }
                                .accessibilityHint(String(localized: String.LocalizationValue(WMString.heroListAccNavigateDetail)))
                                .padding()
                        }
                    }
                }
                .frame(height: 300)
                .background(Color.wmTranspBackground)
            case .loading:
                HStack {
                    Spacer()
                    LoadingView()
                        .padding()
                    Spacer()
                }
                .background(Color.white)
            case .error:
                Text(WMString.searchHeroesError)
                    .font(.wmDescription)
                    .foregroundStyle(Color.wmMain)
            case .hidden:
                EmptyView()
            case .noResults:
                Text(WMString.searchHeroesEmpty)
                    .font(.wmDescription)
                    .foregroundStyle(Color.wmMainText)
            }
        }
        .background(Color.white)
    }
}

#Preview {
    final class SearchFieldViewModelPreview: SearchFieldViewModelProtocol {
        var state: SearchFieldViewState = .loading

        func process(_: SearchFieldViewEvent) async {}
    }
    let viewModel = SearchFieldViewModelPreview()
    return SearchFieldView(searchText: Binding.constant("AAA"), viewModel: viewModel, tapClosure: { _ in })
}
