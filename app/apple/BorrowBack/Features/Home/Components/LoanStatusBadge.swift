import SwiftUI

struct LoanStatusBadge: View {
    @Environment(\.currentDay) private var today

    @ScaledMetric(relativeTo: .caption) private var diameter = 26.0

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

    private var statusSymbol: String {
        if isReturned { return "checkmark" }
        if dueDay < today { return "exclamationmark" }
        if dueDay < dueSoonThreshold { return "clock" }
        return "checkmark"
    }

    private var showsIndicator: Bool {
        isReturned || dueDay < dueSoonThreshold
    }

    var body: some View {
        Image(systemName: statusSymbol)
            .font(.caption.weight(.bold))
            .foregroundStyle(Color("DeepInk"))
            .frame(width: showsIndicator ? diameter : 0, height: showsIndicator ? diameter : 0)
            .background(statusColor.opacity(0.22), in: Circle())
            .opacity(showsIndicator ? 1 : 0)
            .accessibilityLabel(statusTitle)
            .accessibilityHidden(false)
    }
}
