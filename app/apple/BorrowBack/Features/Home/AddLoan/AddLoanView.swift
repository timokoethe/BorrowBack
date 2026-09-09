//
//  AddLoanView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftData
import SwiftUI

/// Creates a loan from an empty form.
struct AddLoanView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var draft = LoanDraft()
    @State private var isShowingSaveError = false

    var body: some View {
        LoanFormView(
            draft: $draft,
            navigationTitle: "New Loan",
            earliestDueDate: .now,
            focusesTitle: true,
            onSave: save
        )
        .alert("Save failed", isPresented: $isShowingSaveError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("The loan could not be saved.")
        }
    }

    private func save() {
        guard draft.isValid else { return }

        let loan = draft.makeLoan()
        modelContext.insert(loan)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.delete(loan)
            isShowingSaveError = true
        }
    }
}

#Preview {
    AddLoanView()
        .modelContainer(BBModelContainer.preview())
}
