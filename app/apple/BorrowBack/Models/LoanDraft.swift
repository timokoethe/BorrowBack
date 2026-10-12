//
//  LoanDraft.swift
//  BorrowBack
//
//  Created by Claude on 09.09.26.
//

import Foundation

/// The editable content of a loan while a form is open. Keeping it separate
/// from `Loan` lets a form collect changes without touching the persisted
/// model, and puts the mapping between the two in one place.
struct LoanDraft: Equatable {
    var title: String
    var notes: String
    var borrower: Borrower
    var loanedAt: Date
    var dueDate: Date

    /// Days between the loan date and the preselected due date of a new loan.
    static let defaultLoanDurationInDays = 14
    static let notesCharacterLimit = 200

    /// An empty draft for a new loan, lent today.
    init() {
        title = ""
        notes = ""
        borrower = .empty
        loanedAt = .now
        dueDate = Calendar.current.date(
            byAdding: .day,
            value: Self.defaultLoanDurationInDays,
            to: .now
        ) ?? .now
    }

    /// A draft filled with the current content of an existing loan.
    init(loan: Loan) {
        title = loan.title
        notes = loan.notes ?? ""
        borrower = Borrower(
            name: loan.borrowerName,
            contactIdentifier: loan.contactIdentifier,
            phoneNumber: loan.borrowerPhoneNumber
        )
        loanedAt = loan.loanedAt
        dueDate = loan.dueDate
    }

    /// The title as it is persisted, without surrounding whitespace.
    var persistedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Empty notes are absent; internal line breaks and spacing are preserved.
    var persistedNotes: String? {
        let trimmed = notes.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    /// Whether the draft can be saved.
    var isValid: Bool {
        !persistedTitle.isEmpty && borrower.isValid && notes.count <= Self.notesCharacterLimit
    }

    /// A new loan carrying this draft's content.
    func makeLoan() -> Loan {
        Loan(
            title: persistedTitle,
            notes: persistedNotes,
            borrowerName: borrower.persistedName,
            contactIdentifier: borrower.contactIdentifier,
            borrowerPhoneNumber: borrower.phoneNumber,
            loanedAt: loanedAt,
            dueDate: dueDate
        )
    }

    /// Merges only edits made since the form opened into the latest values.
    /// Borrower details form one unit so a name cannot be paired with another
    /// contact's identifier or phone number. Local edits win for the same field.
    func mergingChanges(since original: LoanDraft, into current: LoanDraft) -> LoanDraft {
        var merged = current
        if persistedTitle != original.persistedTitle {
            merged.title = title
        }
        if persistedNotes != original.persistedNotes {
            merged.notes = notes
        }
        if borrower != original.borrower {
            merged.borrower = borrower
        }
        if loanedAt != original.loanedAt {
            merged.loanedAt = loanedAt
        }
        if dueDate != original.dueDate {
            merged.dueDate = dueDate
        }
        return merged
    }

    /// Writes this draft's content onto an existing loan. Whether the loan is
    /// returned stays untouched: a form edits what was lent to whom and when it
    /// was lent and is due, not its returned state.
    func apply(to loan: Loan) {
        loan.title = persistedTitle
        loan.notes = persistedNotes
        loan.borrowerName = borrower.persistedName
        loan.contactIdentifier = borrower.contactIdentifier
        loan.borrowerPhoneNumber = borrower.phoneNumber
        loan.loanedAt = loanedAt
        loan.dueDate = dueDate
    }
}
