import SwiftUI

struct LoanStatusBadge: View {
    @Environment(\.currentDay) private var today

    let dueDate: Date
    let isReturned: Bool

    private var statusTitle: LocalizedStringKey {
        if isReturned {
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
        if isReturned {
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
        Calendar.current.startOfDay(for: dueDate)
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

    var body: some View {
        Text(statusTitle)
            .font(.caption.weight(.semibold))
            .foregroundStyle(Color("DeepInk").opacity(0.8))
            .padding(.horizontal, 9)
            .padding(.vertical, 5)
            .background(statusColor.opacity(0.22), in: Capsule())
    }
}
