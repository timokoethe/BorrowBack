import SwiftUI

/// Shared presentation for failed loan saves. Each flow owns its error state
/// and supplies the localized message appropriate to its operation.
struct PersistenceErrorAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: LocalizedStringKey

    func body(content: Content) -> some View {
        content
            .alert("Save failed", isPresented: $isPresented) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(message)
            }
    }
}

extension View {
    func persistenceErrorAlert(
        isPresented: Binding<Bool>,
        message: LocalizedStringKey
    ) -> some View {
        modifier(PersistenceErrorAlertModifier(isPresented: isPresented, message: message))
    }
}
