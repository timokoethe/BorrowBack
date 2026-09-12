//
//  ArchiveView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftData
import SwiftUI

struct ArchiveView: View {
    @Environment(\.accessibilityReduceMotion) private var accessibilityReduceMotion
    @Environment(\.modelContext) private var modelContext
    @Query(
        filter: #Predicate<Loan> { $0.returnedAt != nil }
    ) private var loans: [Loan]
    @State private var isShowingPersistenceError = false

    var body: some View {
        List {
            HStack {
                BorrowBackWordmark()

                Spacer()
            }
            .listRowInsets(.init(top: 20, leading: 20, bottom: 18, trailing: 20))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

            Text("Archive")
                .font(.title3.weight(.bold))
                .foregroundStyle(Color("DeepInk"))
                .listRowInsets(.init(top: 0, leading: 20, bottom: 8, trailing: 20))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)

            ForEach(sortedLoans) { loan in
                LoanCardView(loan: loan)
                    .listRowInsets(.init(top: 8, leading: 20, bottom: 8, trailing: 20))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            delete(loan)
                        } label: {
                            Label("Delete", systemImage: "trash")
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
                    "No archived loans",
                    systemImage: "archivebox",
                    description: Text("Returned items appear here.")
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
    }

    private var sortedLoans: [Loan] {
        loans.sorted {
            ($0.returnedAt ?? .distantPast) > ($1.returnedAt ?? .distantPast)
        }
    }

    private func delete(_ loan: Loan) {
        withAnimation(loanRemovalAnimation) {
            modelContext.delete(loan)

            do {
                try modelContext.save()
            } catch {
                modelContext.rollback()
                isShowingPersistenceError = true
            }
        }
    }

    private var loanRemovalAnimation: Animation? {
        accessibilityReduceMotion
            ? nil
            : .snappy(duration: 0.22, extraBounce: 0)
    }
}

#Preview {
    NavigationStack {
        ArchiveView()
    }
    .modelContainer(BBModelContainer.preview())
}
