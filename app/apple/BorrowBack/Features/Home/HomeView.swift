//
//  HomeView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(
        filter: #Predicate<Loan> { $0.returnedAt == nil },
        sort: \Loan.dueDate
    ) private var loans: [Loan]
    @State private var presentedSheet: HomeSheet?
    @State private var sort = HomeSort.dueDate

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
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
                    .tint(Color("BBTeal"))
                    .accessibilityLabel("Neue Ausleihe")
                }

                HStack {
                    Text("Übersicht")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color("DeepInk"))

                    Spacer()

                    Menu {
                        Picker("Sortierung", selection: $sort) {
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

                if loans.isEmpty {
                    ContentUnavailableView(
                        "Keine Ausleihen",
                        systemImage: "shippingbox",
                        description: Text("Aktive Ausleihen erscheinen hier.")
                    )
                    .padding(.top, 48)
                } else {
                    LazyVStack(spacing: 16) {
                        ForEach(sortedLoans) { loan in
                            LoanCardView(loan: loan)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .background(Color("WarmIvory"))
        .sheet(item: $presentedSheet) { sheet in
            switch sheet {
            case .addLoan:
                AddLoanView()
            }
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
}

#Preview {
    HomeView()
        .modelContainer(BBModelContainer.preview())
}
