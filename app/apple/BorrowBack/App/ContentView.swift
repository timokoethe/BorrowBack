//
//  ContentView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Übersicht", systemImage: "house.fill") {
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                }
            }

            Tab("Archiv", systemImage: "archivebox") {
                NavigationStack {
                    ContentUnavailableView(
                        "Noch kein Archiv",
                        systemImage: "archivebox",
                        description: Text("Zurückgegebene Gegenstände erscheinen hier.")
                    )
                    .navigationTitle("Archiv")
                }
            }

            Tab("Mehr", systemImage: "ellipsis") {
                NavigationStack {
                    SettingsView()
                }
            }
        }
        .tint(Color("BBTeal"))
    }
}

#Preview {
    ContentView()
}
