//
//  LoanService.swift
//  BorrowBack
//
//  Created by Codex on 21.09.26.
//

import Foundation
import SwiftData

enum LoanServiceError: Error {
    case invalidDraft
}

/// Performs persisted changes to loans while keeping save and rollback
/// behavior out of the views that initiate them.
@MainActor
struct LoanService {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func create(from draft: LoanDraft) throws {
        guard draft.isValid, draft.dueDate >= draft.loanedAt
        else { throw LoanServiceError.invalidDraft }

        modelContext.insert(draft.makeLoan())
        try saveChanges()
    }

    func update(_ loan: Loan, from draft: LoanDraft, original: LoanDraft) throws {
        guard !loan.isDeleted, loan.modelContext != nil
        else { throw LoanServiceError.invalidDraft }

        let merged = draft.mergingChanges(since: original, into: LoanDraft(loan: loan))
        guard merged.isValid, merged.dueDate >= merged.loanedAt
        else { throw LoanServiceError.invalidDraft }

        merged.apply(to: loan)
        try saveChanges()
    }

    func markAsReturned(_ loan: Loan, at returnedAt: Date = .now) throws {
        loan.returnedAt = returnedAt
        try saveChanges()
    }

    func restore(_ loan: Loan) throws {
        loan.returnedAt = nil
        try saveChanges()
    }

    func delete(_ loan: Loan) throws {
        modelContext.delete(loan)
        try saveChanges()
    }

    private func saveChanges() throws {
        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            throw error
        }
    }
}
