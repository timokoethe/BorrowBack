//
//  SampleDataSeeder.swift
//  BorrowBack
//
//  Created by Codex on 12.09.26.
//

import Foundation
import SwiftData

extension BBModelContainer {
    /// Adds stable sample loans for product screenshots without duplicating them
    /// on subsequent launches.
    static func seed(_ modelContext: ModelContext) throws {
        let existingIDs = Set(
            try modelContext.fetch(FetchDescriptor<Loan>()).map(\.id)
        )

        for loan in sampleLoans where !existingIDs.contains(loan.id) {
            modelContext.insert(loan)
        }

        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            throw error
        }
    }

    private static let sampleLoans: [Loan] = [
        Loan(
            id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA801")!,
            title: "Picnic blanket",
            borrowerName: "Sophie Marlow",
            loanedAt: date(2026, 9, 1),
            dueDate: date(2026, 9, 14),
            createdAt: date(2026, 9, 1)
        ),
        Loan(
            id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA802")!,
            title: "Camera",
            borrowerName: "Lilly Reid",
            loanedAt: date(2026, 9, 5),
            dueDate: date(2026, 9, 14),
            createdAt: date(2026, 9, 5)
        ),
        Loan(
            id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA803")!,
            title: "Bike pump",
            borrowerName: "Isabel McCracken",
            loanedAt: date(2026, 9, 9),
            dueDate: date(2026, 9, 23),
            createdAt: date(2026, 9, 9)
        ),
        Loan(
            id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA804")!,
            title: "Camping stove",
            borrowerName: "Lena Hoffmann",
            loanedAt: date(2026, 9, 12),
            dueDate: date(2026, 10, 31),
            createdAt: date(2026, 9, 12)
        ),
        Loan(
            id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA805")!,
            title: "Projector",
            borrowerName: "Noah Becker",
            loanedAt: date(2026, 7, 3),
            dueDate: date(2026, 7, 17),
            returnedAt: date(2026, 7, 16),
            createdAt: date(2026, 7, 3)
        ),
        Loan(
            id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA806")!,
            title: "Board game",
            borrowerName: "Mia Sommer",
            loanedAt: date(2026, 7, 21),
            dueDate: date(2026, 8, 4),
            returnedAt: date(2026, 8, 2),
            createdAt: date(2026, 7, 21)
        ),
        Loan(
            id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA807")!,
            title: "Power drill",
            borrowerName: "Jonas Weber",
            loanedAt: date(2026, 8, 9),
            dueDate: date(2026, 8, 23),
            returnedAt: date(2026, 8, 20),
            createdAt: date(2026, 8, 9)
        )
    ]

    private static func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        var components = DateComponents()
        components.calendar = .current
        components.timeZone = .current
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12

        guard let date = components.date else {
            preconditionFailure("Invalid sample data date: \(year)-\(month)-\(day)")
        }

        return date
    }
}
