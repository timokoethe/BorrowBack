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
    @Environment(\.accessibilityReduceMotion) private var accessibilityReduceMotion
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    private let modelSetup: BBModelContainer.Setup

    init() {
        switch BBModelContainer.make() {
        case .ready(let modelContainer):
            do {
                try BBModelContainer.seedSampleData(modelContainer.mainContext)
                modelSetup = .ready(modelContainer)
            } catch {
                modelSetup = .unavailable
            }
        case .unavailable:
            modelSetup = .unavailable
        }
    }

    var body: some Scene {
        WindowGroup {
            switch modelSetup {
            case .ready(let modelContainer):
                Group {
                    if hasCompletedOnboarding {
                        ContentView()
                            .transition(.opacity)
                    } else {
                        OnboardingView {
                            withAnimation(onboardingTransitionAnimation) {
                                hasCompletedOnboarding = true
                            }
                        }
                        .transition(.opacity)
                    }
                }
                    .modelContainer(modelContainer)
            case .unavailable:
                PersistenceUnavailableView()
            }
        }
    }

    private var onboardingTransitionAnimation: Animation? {
        accessibilityReduceMotion
            ? nil
            : .easeInOut(duration: 0.25)
    }
}
