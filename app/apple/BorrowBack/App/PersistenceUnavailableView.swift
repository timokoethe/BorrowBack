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
            "Data unavailable",
            systemImage: "externaldrive.badge.exclamationmark",
            description: Text(
                "BorrowBack can’t open local storage. Please restart the app."
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("WarmIvory"))
    }
}

#Preview {
    PersistenceUnavailableView()
}
