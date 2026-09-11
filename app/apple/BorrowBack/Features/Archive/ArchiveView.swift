//
//  ArchiveView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftData
import SwiftUI

struct ArchiveView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(
        filter: #Predicate<Loan> { $0.returnedAt != nil }
    ) private var loans: [Loan]
    @State private var isShowingPersistenceError = false
    @State private var loanPendingDeletion: Loan?

    var body: some View {
        Group {
            if loans.isEmpty {
                ContentUnavailableView(
                    "No archived loans",
                    systemImage: "archivebox",
                    description: Text("Returned items appear here.")
                )
            } else {
                List {
                    ForEach(sortedLoans) { loan in
                        LoanCardView(loan: loan)
                            .listRowInsets(.init(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    loanPendingDeletion = loan
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .environment(\.defaultMinListRowHeight, 1)
            }
        }
        .background(Color("WarmIvory"))
        .navigationTitle("Archive")
        .alert(
            "Delete archived loan?",
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
        loans.sorted {
            ($0.returnedAt ?? .distantPast) > ($1.returnedAt ?? .distantPast)
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

    private func delete(_ loan: Loan) {
        modelContext.delete(loan)

        do {
            try modelContext.save()
        } catch {
            modelContext.rollback()
            isShowingPersistenceError = true
        }
    }
}

#Preview {
    NavigationStack {
        ArchiveView()
    }
    .modelContainer(BBModelContainer.preview())
}
