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
    @State private var borrowerName = ""
    @State private var dueDate = Date.now.addingTimeInterval(14 * 24 * 60 * 60)
    @State private var isShowingSaveError = false
    @FocusState private var focusedField: Field?

    var body: some View {
        NavigationStack {
            Form {
                Section("Loan") {
                    TextField("What did you lend?", text: $title)
                        .focused($focusedField, equals: .title)
                }

                Section("Person") {
                    TextField("Name", text: $borrowerName)
                        .textContentType(.name)
                        .focused($focusedField, equals: .borrowerName)
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
                focusedField = .title
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }

    private var canSave: Bool {
        !trimmedTitle.isEmpty && !trimmedBorrowerName.isEmpty
    }

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedBorrowerName: String {
        borrowerName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func save() {
        guard canSave else { return }

        let loan = Loan(
            title: trimmedTitle,
            borrowerName: trimmedBorrowerName,
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

    private enum Field {
        case title
        case borrowerName
    }
}

#Preview {
    AddLoanView()
        .modelContainer(BBModelContainer.preview())
}
