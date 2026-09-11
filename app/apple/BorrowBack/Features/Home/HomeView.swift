//
//  HomeView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(
        filter: #Predicate<Loan> { $0.returnedAt == nil },
        sort: \Loan.dueDate
    ) private var loans: [Loan]
    @State private var sort = HomeSort.dueDate
    @State private var isShowingPersistenceError = false
    @State private var loanPendingDeletion: Loan?

    let onAddLoan: () -> Void
    let onEditLoan: (Loan) -> Void

    init(
        onAddLoan: @escaping () -> Void = {},
        onEditLoan: @escaping (Loan) -> Void = { _ in }
    ) {
        self.onAddLoan = onAddLoan
        self.onEditLoan = onEditLoan
    }

    var body: some View {
        List {
            HStack(alignment: .center) {
                BorrowBackWordmark()

                Spacer()

                Button(action: onAddLoan) {
                    Image(systemName: "plus")
                        .font(.headline.weight(.semibold))
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.circle)
                .controlSize(.regular)
                .accessibilityLabel("New Loan")
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
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            loanPendingDeletion = loan
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
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
        .alert(
            "Delete loan?",
            isPresented: isShowingDeleteConfirmation,
            presenting: loanPendingDeletion
        ) { loan in
            Button("Delete", role: .destructive) {
                delete(loan)
            }
            Button("Cancel", role: .cancel) {}
        } message: { _ in
            Text("This action cannot be undone.")
        }
        .alert("Save failed", isPresented: $isShowingPersistenceError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("The change could not be saved.")
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

    private var isShowingDeleteConfirmation: Binding<Bool> {
        Binding(
            get: { loanPendingDeletion != nil },
            set: { isPresented in
                if !isPresented {
                    loanPendingDeletion = nil
                }
            }
        )
    }

    private func markAsReturned(_ loan: Loan) {
        loan.returnedAt = .now
        saveChanges()
    }

    private func delete(_ loan: Loan) {
        modelContext.delete(loan)
        saveChanges()
    }

    private func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            isShowingPersistenceError = true
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(BBModelContainer.preview())
}
