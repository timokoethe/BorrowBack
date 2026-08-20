//
//  LoanCardView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftUI
import SwiftData

struct LoanCardView: View {
    let loan: Loan

    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                LinearGradient(
                    colors: [Color("BBTeal").opacity(0.78), Color("DeepInk")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Image(systemName: "shippingbox.fill")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundStyle(Color("WarmIvory"))
                    .accessibilityHidden(true)
            }
            .frame(width: 140)
            .clipped()

            VStack(alignment: .leading, spacing: 15) {
                Text(loan.title)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color("DeepInk"))
                    .lineLimit(2)

                Label(loan.borrowerName, systemImage: "person")
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))

                if let returnedAt = loan.returnedAt {
                    Label(
                        "Ausgeliehen: \(loan.loanedAt.formatted(date: .long, time: .omitted))",
                        systemImage: "calendar"
                    )
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(2)

                    Label(
                        "Rückgabe: \(returnedAt.formatted(date: .long, time: .omitted))",
                        systemImage: "calendar.badge.checkmark"
                    )
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(2)
                } else {
                    Label(
                        loan.dueDate.formatted(date: .long, time: .omitted),
                        systemImage: "calendar"
                    )
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                }

                Text(statusTitle)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color("DeepInk"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(statusColor.opacity(0.28), in: Capsule())
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
        }
        .frame(minHeight: 192)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color("DeepInk").opacity(0.09), radius: 10, y: 5)
        .accessibilityElement(children: .combine)
    }

    private var statusTitle: String {
        if loan.returnedAt != nil {
            return "Zurückgegeben"
        }

        if loan.dueDate < .now {
            return "Überfällig"
        }

        if loan.dueDate < Date.now.addingTimeInterval(7 * 24 * 60 * 60) {
            return "Bald fällig"
        }

        return "OK"
    }

    private var statusColor: Color {
        switch statusTitle {
        case "Überfällig":
            Color("Coral")
        case "Bald fällig":
            Color("Amber")
        default:
            Color("BBTeal")
        }
    }
}

#Preview {
    LoanCardView(loan: Loan(
        title: "Akkuschrauber",
        borrowerName: "Tobias Wagner",
        dueDate: .now.addingTimeInterval(14 * 24 * 60 * 60)
    ))
    .padding()
    .background(Color("WarmIvory"))
    .modelContainer(BBModelContainer.preview())
}
