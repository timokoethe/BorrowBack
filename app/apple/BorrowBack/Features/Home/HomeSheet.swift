//
//  HomeSheet.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import Foundation

enum HomeSheet: Identifiable {
    case editLoan(Loan)

    var id: String {
        switch self {
        case .editLoan(let loan):
            loan.id.uuidString
        }
    }
}
