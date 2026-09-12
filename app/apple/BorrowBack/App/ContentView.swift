//
//  ContentView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var presentedSheet: HomeSheet?
    @State private var homePath: [HomeRoute] = []

    var body: some View {
        TabView {
            Tab("Overview", systemImage: "house.fill") {
                NavigationStack(path: $homePath) {
                    HomeView(
                        onAddLoan: {
                            homePath.append(.addLoan)
                        },
                        onEditLoan: { loan in
                            presentedSheet = .editLoan(loan)
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
            switch sheet {
            case .editLoan(let loan):
                EditLoanView(loan: loan)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(BBModelContainer.preview())
}
