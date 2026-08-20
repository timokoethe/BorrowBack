//
//  BorrowBackApp.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftUI
import SwiftData

@main
struct BorrowBackApp: App {
    private let modelSetup = BBModelContainer.make()

    var body: some Scene {
        WindowGroup {
            switch modelSetup {
            case .ready(let modelContainer):
                ContentView()
                    .modelContainer(modelContainer)
            case .unavailable:
                PersistenceUnavailableView()
            }
        }
    }
}
