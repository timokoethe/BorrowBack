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
    @State private var hasPendingMessageSendError = false
    @State private var isShowingMessageSendError = false

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
        .sheet(item: $presentedSheet, onDismiss: handleSheetDismissal) { sheet in
            switch sheet {
            case .editLoan(let loan):
                EditLoanView(loan: loan)
            case .reminder(let message):
                MessageComposerView(message: message) {
                    hasPendingMessageSendError = true
                }
            }
        }
        .alert("Message not sent", isPresented: $isShowingMessageSendError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("The reminder could not be sent. Please try again.")
        }
    }

    private func handleSheetDismissal() {
        guard hasPendingMessageSendError else { return }

        hasPendingMessageSendError = false
        isShowingMessageSendError = true
    }
}

#Preview {
    ContentView()
        .modelContainer(BBModelContainer.preview())
}
