//
//  CurrentDay.swift
//  BorrowBack
//
//  Created by Codex on 31.08.26.
//

import Combine
import SwiftUI

extension EnvironmentValues {
    /// Start of the current calendar day. Views that derive state from "today",
    /// such as loan status, read this instead of `Date.now` so they refresh when
    /// the day changes.
    @Entry var currentDay: Date = Calendar.current.startOfDay(for: .now)
}

extension View {
    /// Keeps `\.currentDay` up to date for this view hierarchy.
    func trackingCurrentDay() -> some View {
        modifier(CurrentDayModifier())
    }
}

private struct CurrentDayModifier: ViewModifier {
    @Environment(\.scenePhase) private var scenePhase
    @State private var currentDay = Calendar.current.startOfDay(for: .now)

    func body(content: Content) -> some View {
        content
            .environment(\.currentDay, currentDay)
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    refresh()
                }
            }
            .onReceive(dayChanges) { _ in
                refresh()
            }
    }

    private var dayChanges: some Publisher<Notification, Never> {
        NotificationCenter.default
            .publisher(for: .NSCalendarDayChanged)
            .receive(on: DispatchQueue.main)
    }

    private func refresh() {
        let today = Calendar.current.startOfDay(for: .now)

        if today != currentDay {
            currentDay = today
        }
    }
}
