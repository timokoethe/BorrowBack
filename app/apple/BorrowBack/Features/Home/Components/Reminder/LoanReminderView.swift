import SwiftUI
import UIKit

struct LoanReminderView: View {
    @Environment(\.dismiss) private var dismiss

    let message: LoanReminderMessage

    @State private var text: String
    @State private var isShowingComposer = false
    @State private var isShowingMessagingUnavailable = false
    @State private var hasPendingSendError = false
    @State private var isShowingSendError = false
    @State private var hasCopied = false
    @FocusState private var isEditing: Bool
    @ScaledMetric(relativeTo: .body) private var editorHeight = 180.0

    init(message: LoanReminderMessage) {
        self.message = message
        _text = State(initialValue: message.body)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Reminder message")
                        .font(.headline)
                        .foregroundStyle(Color("DeepInk"))

                    TextEditor(text: $text)
                        .focused($isEditing)
                        .scrollContentBackground(.hidden)
                        .frame(maxHeight: editorHeight)
                        .padding(8)
                        .background(.background, in: RoundedRectangle(cornerRadius: 12))
                        .accessibilityLabel("Reminder message")
                }

                VStack(spacing: 12) {
                    Button(action: send) {
                        Label("Send", systemImage: "paperplane")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Button {
                        UIPasteboard.general.string = text
                        hasCopied = true
                    } label: {
                        Label(
                            hasCopied ? LocalizedStringKey("Copied") : LocalizedStringKey("Copy"),
                            systemImage: hasCopied ? "checkmark" : "doc.on.doc"
                        )
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .labelStyle(.titleAndIcon)
                .controlSize(.large)
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color("WarmIvory"))
            .navigationTitle("Reminder message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Close")
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .onChange(of: text) {
            hasCopied = false
        }
        .sheet(isPresented: $isShowingComposer, onDismiss: handleComposerDismissal) {
            MessageComposerView(recipient: message.recipient, messageBody: text) {
                hasPendingSendError = true
            }
        }
        .alert("Messages unavailable", isPresented: $isShowingMessagingUnavailable) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This device is not configured to send messages.")
        }
        .alert("Message not sent", isPresented: $isShowingSendError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("The reminder could not be sent. Please try again.")
        }
    }

    private func send() {
        isEditing = false
        guard MessageComposerView.canSendText else {
            isShowingMessagingUnavailable = true
            return
        }

        isShowingComposer = true
    }

    private func handleComposerDismissal() {
        guard hasPendingSendError else { return }

        hasPendingSendError = false
        isShowingSendError = true
    }
}

#Preview {
    let loan = Loan(
        title: "Camera",
        borrowerName: "Alex",
        borrowerPhoneNumber: "+491234567890",
        dueDate: .now
    )
    if let message = LoanReminderMessage(
        loan: loan,
        today: Calendar.current.startOfDay(for: .now),
        locale: .current
    ) {
        LoanReminderView(message: message)
    }
}
