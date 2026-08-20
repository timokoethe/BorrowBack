//
//  BBModelContainer.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftData

enum BBModelContainer {
    enum Setup {
        case ready(ModelContainer)
        case unavailable
    }

    static func make() -> Setup {
        let configuration = ModelConfiguration(cloudKitDatabase: .none)

        do {
            return .ready(
                try ModelContainer(
                    for: Loan.self,
                    configurations: configuration
                )
            )
        } catch {
            return .unavailable
        }
    }

    static func preview(loans: [Loan] = []) -> ModelContainer {
        let configuration = ModelConfiguration(
            isStoredInMemoryOnly: true,
            cloudKitDatabase: .none
        )

        do {
            let container = try ModelContainer(
                for: Loan.self,
                configurations: configuration
            )
            loans.forEach(container.mainContext.insert)
            return container
        } catch {
            fatalError("Could not create BorrowBack preview model container: \(error)")
        }
    }

}
