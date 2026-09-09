//
//  EditLoanView.swift
//  BorrowBack
//
//  Created by Claude on 09.09.26.
//

import SwiftData
import SwiftUI

/// Edits an existing loan in the same form used to create one.
struct EditLoanView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    private let loan: Loan

    @State private var draft: LoanDraft
    @State private var isShowingSaveError = false

    init(loan: Loan) {
        self.loan = loan
        _draft = State(initialValue: LoanDraft(loan: loan))
    }

    var body: some View {
        LoanFormView(
            draft: $draft,
            navigationTitle: "Edit Loan",
            earliestDueDate: earliestDueDate,
            focusesTitle: false,
            onSave: save
        )
        .alert("Save failed", isPresented: $isShowingSaveError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("The change could not be saved.")
        }
    }

    /// An overdue loan keeps its due date selectable, so editing the title of
    /// a late loan does not force its date forward.
    private var earliestDueDate: Date {
        min(loan.dueDate, .now)
    }

    private func save() {
        guard draft.isValid else { return }

        draft.apply(to: loan)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            isShowingSaveError = true
        }
    }
}

#Preview {
    EditLoanView(
        loan: Loan(
            title: "Akkuschrauber",
            borrowerName: "Tobias Wagner",
            dueDate: .now.addingTimeInterval(3 * 24 * 60 * 60)
        )
    )
    .modelContainer(BBModelContainer.preview())
}
