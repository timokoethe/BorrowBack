//
//  ArchiveView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftData
import SwiftUI

struct ArchiveView: View {
    @Query(
        filter: #Predicate<Loan> { $0.returnedAt != nil }
    ) private var loans: [Loan]

    var body: some View {
        Group {
            if loans.isEmpty {
                ContentUnavailableView(
                    "No archived loans",
                    systemImage: "archivebox",
                    description: Text("Returned items appear here.")
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(sortedLoans) { loan in
                            LoanCardView(loan: loan)
                        }
                    }
                    .padding(20)
                }
            }
        }
        .background(Color("WarmIvory"))
        .navigationTitle("Archive")
    }

    private var sortedLoans: [Loan] {
        loans.sorted {
            ($0.returnedAt ?? .distantPast) > ($1.returnedAt ?? .distantPast)
        }
    }
}

#Preview {
    NavigationStack {
        ArchiveView()
    }
    .modelContainer(BBModelContainer.preview())
}
