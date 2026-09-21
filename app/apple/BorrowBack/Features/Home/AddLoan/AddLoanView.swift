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
        ZStack {
            Color("WarmIvory")
                .ignoresSafeArea()

            LoanFormView(
                draft: $draft,
                navigationTitle: "New Loan",
                focusesTitle: true,
                presentationStyle: .pushed,
                onSave: save
            )
        }
        .toolbar(.hidden, for: .tabBar)
        .alert("Save failed", isPresented: $isShowingSaveError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("The loan could not be saved.")
        }
    }

    private func save() {
        guard draft.isValid else { return }

        do {
            try LoanService(modelContext: modelContext).create(from: draft)
            dismiss()
        } catch {
            isShowingSaveError = true
        }
    }
}

#Preview {
    NavigationStack {
        AddLoanView()
    }
    .modelContainer(BBModelContainer.preview())
}
