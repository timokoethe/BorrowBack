//
//  HomeView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.accessibilityReduceMotion) private var accessibilityReduceMotion
    @Environment(\.currentDay) private var today
    @Environment(\.locale) private var locale
    @Environment(\.modelContext) private var modelContext
    @Query(
        filter: #Predicate<Loan> { $0.returnedAt == nil },
        sort: \Loan.dueDate
    ) private var loans: [Loan]
    @State private var sort = HomeSort.dueDate
    @State private var isShowingMessagingUnavailable = false
    @State private var isShowingPersistenceError = false

    let onAddLoan: () -> Void
    let onEditLoan: (Loan) -> Void
    let onWriteReminder: (LoanReminderMessage) -> Void

    init(
        onAddLoan: @escaping () -> Void = {},
        onEditLoan: @escaping (Loan) -> Void = { _ in },
        onWriteReminder: @escaping (LoanReminderMessage) -> Void = { _ in }
    ) {
        self.onAddLoan = onAddLoan
        self.onEditLoan = onEditLoan
        self.onWriteReminder = onWriteReminder
    }

    var body: some View {
        List {
            HStack(alignment: .center) {
                BorrowBackWordmark(animatesOnAppear: true)

                Spacer()

                Button(action: onAddLoan) {
                    Image(systemName: "plus")
                        .font(.headline.weight(.semibold))
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.circle)
                .controlSize(.regular)
                .accessibilityLabel("New Loan")
                .accessibilityInputLabels([
                    Text("New Loan"),
                    Text("Add loan"),
                    Text("Plus")
                ])
            }
                .listRowInsets(.init(top: 20, leading: 20, bottom: 18, trailing: 20))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)

            HStack(alignment: .firstTextBaseline) {
                Text("Active loans")
                    .font(.title3.weight(.bold))
                .foregroundStyle(Color("DeepInk"))

                Spacer()

                Menu {
                    Picker("Sort order", selection: $sort) {
                        ForEach(HomeSort.allCases) { option in
                            Text(option.title)
                                .tag(option)
                        }
                    }
                } label: {
                    HStack(spacing: 6) {
                        Text(sort.shortTitle)
                        Image(systemName: "chevron.down")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.7))
                }
                .accessibilityLabel("Sort order")
                .accessibilityValue(Text(sort.title))
                .accessibilityInputLabels([Text("Sort order"), Text(sort.shortTitle)])
            }
            .listRowInsets(.init(top: 0, leading: 20, bottom: 8, trailing: 20))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

            if !loans.isEmpty {
                ForEach(sortedLoans) { loan in
                    Button {
                        onEditLoan(loan)
                    } label: {
                        LoanCardView(loan: loan)
                    }
                    .buttonStyle(.plain)
                    .accessibilityInputLabels([Text(verbatim: loan.title)])
                    .contextMenu {
                        if loan.borrowerPhoneNumber != nil {
                            Button {
                                writeReminder(for: loan)
                            } label: {
                                Label("Write reminder", systemImage: "message")
                            }
                            .tint(Color.primary)
                        }

                        Button {
                            markAsReturned(loan)
                        } label: {
                            Label("Returned", systemImage: "checkmark")
                        }
                        .tint(Color.primary)

                        Button(role: .destructive) {
                            delete(loan)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                    .listRowInsets(.init(top: 8, leading: 20, bottom: 8, trailing: 20))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            markAsReturned(loan)
                        } label: {
                            Label("Returned", systemImage: "checkmark")
                        }
                        .tint(Color.accentColor)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            delete(loan)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .animation(loanListAnimation, value: sort)
        .listStyle(.plain)
        .scrollDisabled(loans.isEmpty)
        .scrollContentBackground(.hidden)
        .environment(\.defaultMinListRowHeight, 1)
        .background(Color("WarmIvory"))
        .overlay {
            if loans.isEmpty {
                ContentUnavailableView(
                    "No loans",
                    systemImage: "shippingbox",
                    description: Text("Your active loans will appear here.")
                )
                .padding(.horizontal, 20)
                .allowsHitTesting(false)
            }
        }
        .alert("Save failed", isPresented: $isShowingPersistenceError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("The change could not be saved.")
        }
        .alert("Messages unavailable", isPresented: $isShowingMessagingUnavailable) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This device is not configured to send messages.")
        }
    }

    private var sortedLoans: [Loan] {
        switch sort {
        case .dueDate:
            loans.sorted {
                if $0.dueDate == $1.dueDate {
                    return $0.title.localizedStandardCompare($1.title) == .orderedAscending
                }

                return $0.dueDate < $1.dueDate
            }
        case .name:
            loans.sorted {
                $0.title.localizedStandardCompare($1.title) == .orderedAscending
            }
        }
    }

    private func markAsReturned(_ loan: Loan) {
        withAnimation(loanListAnimation) {
            do {
                try LoanService(modelContext: modelContext).markAsReturned(loan)
            } catch {
                isShowingPersistenceError = true
            }
        }
    }

    private func delete(_ loan: Loan) {
        withAnimation(loanListAnimation) {
            do {
                try LoanService(modelContext: modelContext).delete(loan)
            } catch {
                isShowingPersistenceError = true
            }
        }
    }

    private func writeReminder(for loan: Loan) {
        guard MessageComposerView.canSendText else {
            isShowingMessagingUnavailable = true
            return
        }

        guard let message = LoanReminderMessage(
            loan: loan,
            today: today,
            locale: locale
        ) else {
            return
        }

        onWriteReminder(message)
    }

    private var loanListAnimation: Animation? {
        accessibilityReduceMotion
            ? nil
            : .snappy(duration: 0.22, extraBounce: 0)
    }
}

#Preview {
    HomeView()
        .modelContainer(BBModelContainer.preview())
}
