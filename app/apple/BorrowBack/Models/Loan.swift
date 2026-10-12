//
//  Loan.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import Foundation
import SwiftData

@Model
final class Loan {
    var id: UUID = UUID()
    var title: String = ""
    var notes: String?
    var borrowerName: String = ""
    var contactIdentifier: String?
    var borrowerPhoneNumber: String?
    var loanedAt: Date = Date.now
    var dueDate: Date = Date.now
    var returnedAt: Date?
    var imageFilename: String?
    var createdAt: Date = Date.now

    init(
        id: UUID = UUID(),
        title: String,
        notes: String? = nil,
        borrowerName: String,
        contactIdentifier: String? = nil,
        borrowerPhoneNumber: String? = nil,
        loanedAt: Date = .now,
        dueDate: Date,
        returnedAt: Date? = nil,
        imageFilename: String? = nil,
        createdAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.notes = notes
        self.borrowerName = borrowerName
        self.contactIdentifier = contactIdentifier
        self.borrowerPhoneNumber = borrowerPhoneNumber
        self.loanedAt = loanedAt
        self.dueDate = dueDate
        self.returnedAt = returnedAt
        self.imageFilename = imageFilename
        self.createdAt = createdAt
    }
}
