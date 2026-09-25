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
    var borrower: Borrower
    var loanedAt: Date
    var dueDate: Date

    /// Days between the loan date and the preselected due date of a new loan.
    static let defaultLoanDurationInDays = 14

    /// An empty draft for a new loan, lent today.
    init() {
        title = ""
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

    /// Whether the draft can be saved.
    var isValid: Bool {
        !persistedTitle.isEmpty && borrower.isValid
    }

    /// A new loan carrying this draft's content.
    func makeLoan() -> Loan {
        Loan(
            title: persistedTitle,
            borrowerName: borrower.persistedName,
            contactIdentifier: borrower.contactIdentifier,
            borrowerPhoneNumber: borrower.phoneNumber,
            loanedAt: loanedAt,
            dueDate: dueDate
        )
    }

    /// Writes this draft's content onto an existing loan. Whether the loan is
    /// returned stays untouched: a form edits what was lent to whom and when it
    /// was lent and is due, not its returned state.
    func apply(to loan: Loan) {
        loan.title = persistedTitle
        loan.borrowerName = borrower.persistedName
        loan.contactIdentifier = borrower.contactIdentifier
        loan.borrowerPhoneNumber = borrower.phoneNumber
        loan.loanedAt = loanedAt
        loan.dueDate = dueDate
    }
}
