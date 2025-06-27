import SwiftUI

public struct ErrorView: View {
    public init(
        errorTitle: String = WMString.genericErrorTitle,
        errorMessage: String = WMString.genericErrorMessage,
        onRetry: @escaping () -> Void) {
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        self.onRetry = onRetry
    }

    var errorTitle: String
    var errorMessage: String
    var onRetry: () -> Void

    public var body: some View {
        VStack(spacing: 20) {
            Image(.error)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.yellow)

            Text(String(localized: String.LocalizationValue(errorTitle), bundle: .module))
                .font(.title)
                .fontWeight(.bold)

            Text(String(localized: String.LocalizationValue(errorMessage), bundle: .module))
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Button(action: onRetry) {
                Text(WMString.genericErrorRetryButton)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.wmMain)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ErrorView(onRetry: {})
}
