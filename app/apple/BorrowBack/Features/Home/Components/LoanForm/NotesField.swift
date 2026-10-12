import SwiftUI

/// Multiline notes input with a limit measured in user-perceived characters.
struct NotesField: View {
    @Binding var notes: String
    @State private var input: String

    init(notes: Binding<String>) {
        _notes = notes
        _input = State(initialValue: notes.wrappedValue)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Add a note…", text: $input, axis: .vertical)
                .lineLimit(3...6)
                .accessibilityLabel("Notes (optional)")
                .onChange(of: input) { oldValue, newValue in
                    // Keep a separate input state so a rejected edit triggers
                    // an update of the text field even if the draft is unchanged.
                    let limited: String
                    if oldValue.count >= LoanDraft.notesCharacterLimit,
                       newValue.count > oldValue.count {
                        limited = oldValue
                    } else {
                        limited = String(newValue.prefix(LoanDraft.notesCharacterLimit))
                    }
                    input = limited
                    notes = limited
                }

            Text("\(notes.count) / \(LoanDraft.notesCharacterLimit) characters")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .onChange(of: notes) { _, newValue in
            if input != newValue {
                input = newValue
            }
        }
    }
}

#Preview {
    @Previewable @State var notes = ""

    Form {
        Section("Notes (optional)") {
            NotesField(notes: $notes)
        }
    }
}
