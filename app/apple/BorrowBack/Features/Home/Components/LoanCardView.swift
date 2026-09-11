//
//  LoanCardView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftUI
import SwiftData

struct LoanCardView: View {
    @Environment(\.currentDay) private var today

    let loan: Loan

    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                LinearGradient(
                    colors: [Color("BBTeal").opacity(0.78), Color("ThumbnailInk")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Image(systemName: "shippingbox.fill")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(Color("ThumbnailIcon"))
                    .accessibilityHidden(true)
            }
            .frame(width: 92)
            .frame(maxHeight: .infinity)

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(loan.title)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(Color("DeepInk"))
                        .lineLimit(2)

                    Spacer(minLength: 4)

                    statusBadge
                }

                Label(loan.borrowerName, systemImage: borrowerSymbol)
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(1)

                if let returnedAt = loan.returnedAt {
                    Label {
                        HStack(spacing: 4) {
                            Text("Lent:")
                            Text(loan.loanedAt, format: .dateTime.day().month(.twoDigits).year())
                        }
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(1)

                    Label {
                        HStack(spacing: 4) {
                            Text("Returned:")
                            Text(returnedAt, format: .dateTime.day().month(.twoDigits).year())
                        }
                    } icon: {
                        Image(systemName: "calendar.badge.checkmark")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(1)
                } else {
                    Label {
                        Text(loan.dueDate, format: .dateTime.day().month(.wide).year())
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(1)
                }
            }
            .padding(14)
        }
        .background(Color("CardSurface"))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color("DeepInk").opacity(0.06), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
        .accessibilityElement(children: .combine)
    }

    private var statusBadge: some View {
        Text(statusTitle)
            .font(.caption.weight(.semibold))
            .foregroundStyle(Color("DeepInk").opacity(0.8))
            .padding(.horizontal, 9)
            .padding(.vertical, 5)
            .background(statusColor.opacity(0.22), in: Capsule())
    }

    /// A linked contact is marked on the card, a free-text name is not.
    private var borrowerSymbol: String {
        loan.contactIdentifier == nil ? "person" : "person.crop.circle.fill"
    }

    private var statusTitle: LocalizedStringKey {
        if loan.returnedAt != nil {
            return "Returned"
        }

        if dueDay < today {
            return "Overdue"
        }

        if dueDay < dueSoonThreshold {
            return "Due soon"
        }

        return "OK"
    }

    private var statusColor: Color {
        if loan.returnedAt != nil {
            Color("BBTeal")
        } else if dueDay < today {
            Color("Coral")
        } else if dueDay < dueSoonThreshold {
            Color("Amber")
        } else {
            Color("BBTeal")
        }
    }

    private var dueDay: Date {
        Calendar.current.startOfDay(for: loan.dueDate)
    }

    /// A loan counts as due soon within this many days of its due date.
    private static let dueSoonWindowInDays = 5

    private var dueSoonThreshold: Date {
        Calendar.current.date(
            byAdding: .day,
            value: Self.dueSoonWindowInDays,
            to: today
        ) ?? today
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
