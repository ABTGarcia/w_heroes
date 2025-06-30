import SwiftUI

public struct ErrorView: View {
    public init(
        errorTitle: String = WMString.genericErrorTitle,
        errorMessage: String = WMString.genericErrorMessage,
        onRetry: @escaping () -> Void
    ) {
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        self.onRetry = onRetry
    }

    var errorTitle: String
    var errorMessage: String
    var onRetry: () -> Void

    public var body: some View {
        VStack(spacing: .spacingM) {
            Image(.error)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .accessibilityHidden(true)

            Text(String(localized: String.LocalizationValue(errorTitle), bundle: .module))
                .font(.wmHeader)
                .multilineTextAlignment(.center)
                .foregroundColor(.wmMainText)

            Text(String(localized: String.LocalizationValue(errorMessage), bundle: .module))
                .font(.wmTitle)
                .multilineTextAlignment(.center)
                .foregroundColor(.wmSecondaryText)
                .padding(.horizontal)

            Button(action: onRetry) {
                Text(WMString.genericErrorRetryButton)
                    .font(.wmTitle)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.wmMain)
                    .foregroundColor(.wmLightText)
                    .cornerRadius(12)
            }
            .padding(.horizontal, .spacingL)
            .accessibilityHint(String(localized: String.LocalizationValue(WMString.errorAccRetry), bundle: .module))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorView(onRetry: {})
}
