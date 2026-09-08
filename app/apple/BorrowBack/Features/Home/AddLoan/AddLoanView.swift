//
//  AddLoanView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftData
import SwiftUI

struct AddLoanView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var borrower = Borrower.empty
    @State private var dueDate = Date.now.addingTimeInterval(14 * 24 * 60 * 60)
    @State private var isShowingSaveError = false
    @FocusState private var isTitleFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section("Loan") {
                    TextField("What did you lend?", text: $title)
                        .focused($isTitleFocused)
                }

                Section("Person") {
                    BorrowerField(borrower: $borrower)
                }

                Section("Return") {
                    DatePicker(
                        "Due on",
                        selection: $dueDate,
                        in: Date.now...,
                        displayedComponents: .date
                    )
                }
            }
            .formStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Color("WarmIvory"))
            .navigationTitle("New Loan")
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
                        save()
                    } label: {
                        Image(systemName: "checkmark")
                            .fontWeight(.semibold)
                    }
                    .disabled(!canSave)
                    .accessibilityLabel("Save")
                }
            }
            .alert("Save failed", isPresented: $isShowingSaveError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("The loan could not be saved.")
            }
            .onAppear {
                isTitleFocused = true
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }

    private var canSave: Bool {
        !trimmedTitle.isEmpty && borrower.isValid
    }

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func save() {
        guard canSave else { return }

        let loan = Loan(
            title: trimmedTitle,
            borrowerName: borrower.persistedName,
            contactIdentifier: borrower.contactIdentifier,
            dueDate: dueDate
        )
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
