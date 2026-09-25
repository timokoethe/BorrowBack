//
//  LoanReminderMessage.swift
//  BorrowBack
//
//  Created by Codex on 25.09.26.
//

import Foundation

/// The lightweight, fully prepared content needed to present the system
/// message composer for one loan.
struct LoanReminderMessage: Identifiable {
    let id: UUID
    let recipient: String
    let body: String

    init?(loan: Loan, today: Date, locale: Locale) {
        guard let recipient = loan.borrowerPhoneNumber else { return nil }

        id = loan.id
        self.recipient = recipient

        let dueDate = loan.dueDate.formatted(
            Date.FormatStyle(date: .long, time: .omitted).locale(locale)
        )
        let dueDay = Calendar.current.startOfDay(for: loan.dueDate)
        let format: String

        if dueDay < today {
            format = String(localized: "Hi! Just a quick reminder: You still have my “%1$@”. It was due back on %2$@. When would be a good time to return it?", locale: locale)
        } else {
            format = String(localized: "Hi! Just a quick reminder: You still have my “%1$@”. We planned for it to be returned on %2$@. Does that still work for you?", locale: locale)
        }

        body = String(format: format, locale: locale, loan.title, dueDate)
    }
}
