//
//  PersistenceUnavailableView.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftUI

struct PersistenceUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "Daten nicht verfügbar",
            systemImage: "externaldrive.badge.exclamationmark",
            description: Text(
                "BorrowBack kann den lokalen Speicher nicht öffnen. Bitte starte die App neu."
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("WarmIvory"))
    }
}

#Preview {
    PersistenceUnavailableView()
}
