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

    var body: some View {
        TabView {
            Tab("Overview", systemImage: "house.fill") {
                NavigationStack {
                    HomeView(
                        onAddLoan: {
                            presentedSheet = .addLoan
                        },
                        onEditLoan: { loan in
                            presentedSheet = .editLoan(loan)
                        }
                    )
                    .toolbar(.hidden, for: .navigationBar)
                }
            }

            Tab("Archive", systemImage: "archivebox") {
                NavigationStack {
                    ArchiveView()
                }
            }
        }
        .tint(.accentColor)
        .trackingCurrentDay()
        .sheet(item: $presentedSheet) { sheet in
            switch sheet {
            case .addLoan:
                AddLoanView()
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
