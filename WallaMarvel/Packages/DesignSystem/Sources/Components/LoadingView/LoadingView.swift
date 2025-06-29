import SwiftUI

public struct LoadingView: View {
    @State private var isAnimating = false

    public init() {}

    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0 ..< 3) { index in
                Circle()
                    .fill(Color.wmMain)
                    .frame(width: 16, height: 16)
                    .scaleEffect(isAnimating ? 1.0 : 0.5)
                    .opacity(isAnimating ? 1.0 : 0.5)
                    .animation(
                        .easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        }
        .accessibilityLabel(String(localized: String.LocalizationValue(WMString.loading), bundle: .module))
        .onAppear {
            DispatchQueue.main.async {
                isAnimating = true
            }
        }
    }
}

#Preview {
    LoadingView()
}
