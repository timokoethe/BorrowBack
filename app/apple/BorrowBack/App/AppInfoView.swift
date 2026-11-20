//
//  AppInfoView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 02.10.26.
//

import SwiftUI

struct AppInfoView: View {
    @Environment(\.dismiss) private var dismiss

    private let websiteURL = URL(string: "https://borrowback.itstimo.me")!
    private let privacyURL = URL(string: "https://borrowback.itstimo.me/privacy")!

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Link(destination: websiteURL) {
                        Label("Website", systemImage: "globe")
                    }

                    Link(destination: privacyURL) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }
                }

                Section {
                    LabeledContent("Version", value: version)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("WarmIvory"))
            .navigationTitle("About BorrowBack")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Close")
                }
            }
        }
    }

    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
    }
}

#Preview {
    AppInfoView()
}
