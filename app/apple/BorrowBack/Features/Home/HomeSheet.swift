//
//  HomeSheet.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import Foundation

enum HomeSheet: Identifiable {
    case editLoan(Loan)
    case reminder(LoanReminderMessage)

    var id: String {
        switch self {
        case .editLoan(let loan):
            loan.id.uuidString
        case .reminder(let message):
            "reminder-\(message.id.uuidString)"
        }
    }
}
