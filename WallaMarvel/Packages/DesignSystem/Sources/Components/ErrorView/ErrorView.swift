import SwiftUI

public struct ErrorView: View {
    public init(
        errorTitle: String = "Something Went Wrong",
        errorMessage: String = "Please try again later.",
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

            Text(errorTitle)
                .font(.title)
                .fontWeight(.bold)

            Text(errorMessage)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Button(action: onRetry) {
                Text("Retry")
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
