//
//  ContentView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var presentedSheet: HomeSheet?
    @State private var homePath: [HomeRoute] = []

    var body: some View {
        TabView {
            Tab("Overview", systemImage: "house.fill") {
                NavigationStack(path: $homePath) {
                    HomeView(
                        onAddLoan: {
                            if horizontalSizeClass == .regular {
                                presentedSheet = .addLoan
                            } else {
                                homePath.append(.addLoan)
                            }
                        },
                        onEditLoan: { loan in
                            presentedSheet = .editLoan(loan)
                        },
                        onWriteReminder: { message in
                            presentedSheet = .reminder(message)
                        }
                    )
                    .toolbar(.hidden, for: .navigationBar)
                    .navigationDestination(for: HomeRoute.self) { route in
                        switch route {
                        case .addLoan:
                            AddLoanView()
                        }
                    }
                }
            }

            Tab("Archive", systemImage: "archivebox") {
                NavigationStack {
                    ArchiveView()
                        .toolbar(.hidden, for: .navigationBar)
                }
            }
        }
        .tint(.accentColor)
        .trackingCurrentDay()
        .sheet(item: $presentedSheet) { sheet in
            Group {
                switch sheet {
                case .addLoan:
                    NavigationStack {
                        AddLoanView(presentationStyle: .sheet)
                    }
                    .formPresentation(isExpanded: horizontalSizeClass == .regular)
                case .editLoan(let loan):
                    EditLoanView(loan: loan)
                        .formPresentation(isExpanded: horizontalSizeClass == .regular)
                case .reminder(let message):
                    LoanReminderView(message: message)
                        .formPresentation(isExpanded: horizontalSizeClass == .regular, preferredHeight: 500)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(BBModelContainer.preview())
}
