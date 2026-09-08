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
    @State private var presentedSheet: HomeSheet?
    @State private var sort = HomeSort.dueDate
    @State private var isShowingPersistenceError = false

    var body: some View {
        List {
            HStack {
                Text("BorrowBack")
                    .font(.system(size: 38, weight: .bold, design: .serif))
                    .foregroundStyle(Color("DeepInk"))

                Spacer()

                Button {
                    presentedSheet = .addLoan
                } label: {
                    Image(systemName: "plus")
                        .fontWeight(.semibold)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .controlSize(.regular)
                .accessibilityLabel("New Loan")
            }
            .listRowInsets(.init(top: 20, leading: 20, bottom: 18, trailing: 20))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

            HStack {
                Text("Overview")
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
                        Text(sort.title)
                        Image(systemName: "chevron.down")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("DeepInk").opacity(0.7))
                }
            }
            .listRowInsets(.init(top: 0, leading: 20, bottom: 10, trailing: 20))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

            if loans.isEmpty {
                ContentUnavailableView(
                    "No loans",
                    systemImage: "shippingbox",
                    description: Text("Active loans appear here.")
                )
                .listRowInsets(.init(top: 48, leading: 20, bottom: 24, trailing: 20))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            } else {
                ForEach(sortedLoans) { loan in
                    LoanCardView(loan: loan)
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
                                delete(loan)
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
        .sheet(item: $presentedSheet) { sheet in
            switch sheet {
            case .addLoan:
                AddLoanView()
            }
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
