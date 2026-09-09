//
//  LoanFormView.swift
//  BorrowBack
//
//  Created by Claude on 09.09.26.
//

import SwiftUI

/// The shared form behind creating and editing a loan. It collects changes in
/// a `LoanDraft` and reports the confirmation; persistence and error handling
/// belong to the flow that presents it.
struct LoanFormView: View {
    @Binding var draft: LoanDraft

    let navigationTitle: LocalizedStringKey
    /// The earliest date the due date picker offers. A new loan cannot be due
    /// in the past, while an existing one may already be overdue.
    let earliestDueDate: Date
    /// Whether the title field takes focus when the form appears.
    let focusesTitle: Bool
    let onSave: () -> Void

    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTitleFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section("Loan") {
                    TextField("What did you lend?", text: $draft.title)
                        .focused($isTitleFocused)
                }

                Section("Person") {
                    BorrowerField(borrower: $draft.borrower)
                }

                Section("Return") {
                    DatePicker(
                        "Due on",
                        selection: $draft.dueDate,
                        in: earliestDueDate...,
                        displayedComponents: .date
                    )
                }
            }
            .formStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Color("WarmIvory"))
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Cancel")
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        onSave()
                    } label: {
                        Image(systemName: "checkmark")
                            .fontWeight(.semibold)
                    }
                    .disabled(!draft.isValid)
                    .accessibilityLabel("Save")
                }
            }
            .onAppear {
                if focusesTitle {
                    isTitleFocused = true
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    @Previewable @State var draft = LoanDraft()

    LoanFormView(
        draft: $draft,
        navigationTitle: "New Loan",
        earliestDueDate: .now,
        focusesTitle: true,
        onSave: {}
    )
}
