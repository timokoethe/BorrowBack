//
//  ContentView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.08.26.
//

import SwiftUI
import SwiftData

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
                    ArchiveView()
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
        .modelContainer(BBModelContainer.preview())
}
