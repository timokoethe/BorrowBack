//
//  LoanCardView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftUI
import SwiftData

struct LoanCardView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    @ScaledMetric(relativeTo: .subheadline) private var borrowerIconSize = 16.0

    let loan: Loan

    var body: some View {
        HStack(spacing: 0) {
            if !dynamicTypeSize.isAccessibilitySize {
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
            }

            VStack(alignment: .leading, spacing: 10) {
                titleAndStatus

                Label {
                    Text(verbatim: loan.borrowerName)
                } icon: {
                    BorrowerAvatarView(
                        photoData: loan.borrowerPhotoData,
                        fallbackSymbol: borrowerSymbol,
                        size: borrowerIconSize
                    )
                }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                    .fixedSize(horizontal: false, vertical: true)

                if let returnedAt = loan.returnedAt {
                    Label {
                        dateLayout {
                            Text("Lent:")
                            Text(loan.loanedAt, format: .dateTime.day().month(.twoDigits).year())
                        }
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                    .fixedSize(horizontal: false, vertical: true)

                    Label {
                        dateLayout {
                            Text("Returned:")
                            Text(returnedAt, format: .dateTime.day().month(.twoDigits).year())
                        }
                    } icon: {
                        Image(systemName: "calendar.badge.checkmark")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                    .fixedSize(horizontal: false, vertical: true)
                } else {
                    Label {
                        Text(loan.dueDate, format: .dateTime.day().month(.wide).year())
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.65))
                    .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
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

    private var titleAndStatus: some View {
        HStack(alignment: .top, spacing: 8) {
            title
                .frame(maxWidth: .infinity, alignment: .leading)
            LoanStatusBadge(dueDate: loan.dueDate, isReturned: loan.returnedAt != nil)
                .fixedSize()
        }
    }

    private var title: some View {
        Text(loan.title)
            .font(.title3.weight(.semibold))
            .foregroundStyle(Color("DeepInk"))
            .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var dateLayout: AnyLayout {
        dynamicTypeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: 4))
            : AnyLayout(HStackLayout(spacing: 4))
    }

    /// A linked contact is marked on the card, a free-text name is not.
    private var borrowerSymbol: String {
        loan.contactIdentifier == nil ? "person" : "person.crop.circle.fill"
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
