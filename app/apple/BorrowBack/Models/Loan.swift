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
    @Attribute(.unique) var id: UUID
    var title: String
    var borrowerName: String
    var contactIdentifier: String?
    var loanedAt: Date
    var dueDate: Date
    var returnedAt: Date?
    var imageFilename: String?
    var createdAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        borrowerName: String,
        contactIdentifier: String? = nil,
        loanedAt: Date = .now,
        dueDate: Date,
        returnedAt: Date? = nil,
        imageFilename: String? = nil,
        createdAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.borrowerName = borrowerName
        self.contactIdentifier = contactIdentifier
        self.loanedAt = loanedAt
        self.dueDate = dueDate
        self.returnedAt = returnedAt
        self.imageFilename = imageFilename
        self.createdAt = createdAt
    }
}
