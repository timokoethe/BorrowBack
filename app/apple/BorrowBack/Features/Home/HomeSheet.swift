//
//  HomeSheet.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import Foundation

enum HomeSheet: Identifiable {
    case addLoan
    case editLoan(Loan)

    var id: String {
        switch self {
        case .addLoan:
            "add-loan"
        case .editLoan(let loan):
            loan.id.uuidString
        }
    }
}
