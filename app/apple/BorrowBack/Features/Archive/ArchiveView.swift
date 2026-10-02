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
    @State private var isShowingAppInfo = false

    var body: some View {
        List {
            HStack(alignment: .center) {
                BorrowBackWordmark(animatesOnAppear: true)

                Spacer()

                Button {
                    isShowingAppInfo = true
                } label: {
                    Image(systemName: "info")
                        .font(.headline.weight(.semibold))
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.circle)
                .controlSize(.regular)
                .accessibilityLabel("About BorrowBack")
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
                    .contextMenu {
                        Button {
                            restore(loan)
                        } label: {
                            Label("Restore", systemImage: "arrow.uturn.backward")
                        }
                        .tint(Color.primary)

                        Button(role: .destructive) {
                            delete(loan)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            restore(loan)
                        } label: {
                            Label("Restore", systemImage: "arrow.uturn.backward")
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
        .sheet(isPresented: $isShowingAppInfo) {
            AppInfoView()
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

    /// Clears the return of an archived loan so it becomes active again. The
    /// due date stays as it was, so a loan restored after that date is overdue.
    private func restore(_ loan: Loan) {
        withAnimation(loanRemovalAnimation) {
            do {
                try LoanService(modelContext: modelContext).restore(loan)
            } catch {
                isShowingPersistenceError = true
            }
        }
    }

    private func delete(_ loan: Loan) {
        withAnimation(loanRemovalAnimation) {
            do {
                try LoanService(modelContext: modelContext).delete(loan)
            } catch {
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
