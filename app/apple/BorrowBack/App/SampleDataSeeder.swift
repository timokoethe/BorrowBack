//
//  SampleDataSeeder.swift
//  BorrowBack
//
//  Created by Codex on 12.09.26.
//

import Foundation
import SwiftData

extension BBModelContainer {
    /// Refreshes the dates and return state of known screenshot fixtures on each
    /// debug launch, keeping every status represented without creating duplicates.
    /// Release builds never seed or refresh records.
    static func seedSampleData(_ modelContext: ModelContext) throws {
        #if DEBUG
        let existingLoans = try modelContext.fetch(FetchDescriptor<Loan>())

        for sample in sampleLoans {
            if let existing = existingLoans.first(where: { $0.id == sample.id }) {
                existing.title = sample.title
                existing.loanedAt = sample.loanedAt
                existing.dueDate = sample.dueDate
                existing.returnedAt = sample.returnedAt
                existing.createdAt = sample.createdAt
            } else {
                modelContext.insert(sample)
            }
        }

        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            throw error
        }
        #endif
    }

    #if DEBUG
    private static var sampleLoans: [Loan] {
        let today = Calendar.current.startOfDay(for: .now)

        func date(_ offset: Int) -> Date {
            guard let day = Calendar.current.date(byAdding: .day, value: offset, to: today),
                  let noon = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: day)
            else {
                preconditionFailure("Invalid sample data day offset: \(offset)")
            }
            return noon
        }

        return [
            Loan(
                id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA801")!,
                title: "Picnic blanket",
                borrowerName: "Sophie Marlow",
                loanedAt: date(-17),
                dueDate: date(-3),
                createdAt: date(-17)
            ),
            Loan(
                id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA802")!,
                title: "Camera",
                borrowerName: "Lilly Reid",
                loanedAt: date(-14),
                dueDate: date(0),
                createdAt: date(-14)
            ),
            Loan(
                id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA803")!,
                title: "Bike pump",
                borrowerName: "Isabel McCracken",
                loanedAt: date(-7),
                dueDate: date(3),
                createdAt: date(-7)
            ),
            Loan(
                id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA804")!,
                title: "Camping stove",
                borrowerName: "Lena Hoffmann",
                loanedAt: date(-2),
                dueDate: date(14),
                createdAt: date(-2)
            ),
            Loan(
                id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA805")!,
                title: "Projector",
                borrowerName: "Noah Becker",
                loanedAt: date(-26),
                dueDate: date(-12),
                returnedAt: date(-13),
                createdAt: date(-26)
            ),
            Loan(
                id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA806")!,
                title: "Board game",
                borrowerName: "Mia Sommer",
                loanedAt: date(-20),
                dueDate: date(-6),
                returnedAt: date(-7),
                createdAt: date(-20)
            ),
            Loan(
                id: UUID(uuidString: "211CB936-261D-4A32-BECD-A103078DA807")!,
                title: "Power drill",
                borrowerName: "Jonas Weber",
                loanedAt: date(-12),
                dueDate: date(-1),
                returnedAt: date(-2),
                createdAt: date(-12)
            )
        ]
    }
    #endif
}
