//
//  BBModelContainer.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftData

enum BBModelContainer {
    static func make() -> ModelContainer {
        let configuration = ModelConfiguration(cloudKitDatabase: .none)

        do {
            return try ModelContainer(
                for: Loan.self,
                configurations: configuration
            )
        } catch {
            return fallbackContainer(after: error)
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

    private static func fallbackContainer(after persistentStoreError: Error) -> ModelContainer {
        let configuration = ModelConfiguration(
            isStoredInMemoryOnly: true,
            cloudKitDatabase: .none
        )

        do {
            return try ModelContainer(
                for: Loan.self,
                configurations: configuration
            )
        } catch {
            fatalError(
                "Could not create persistent or temporary BorrowBack model container. "
                    + "Persistent error: \(persistentStoreError). Temporary error: \(error)"
            )
        }
    }
}
