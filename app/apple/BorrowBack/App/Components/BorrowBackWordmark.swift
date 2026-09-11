//
//  BorrowBackWordmark.swift
//  BorrowBack
//
//  Created by Codex on 12.09.26.
//

import SwiftUI

/// The shared wordmark that anchors the app's primary tabs.
struct BorrowBackWordmark: View {
    var body: some View {
        Text("BorrowBack")
            .font(.system(size: 36, weight: .bold, design: .serif))
            .foregroundStyle(Color("DeepInk"))
    }
}

#Preview {
    BorrowBackWordmark()
        .padding()
        .background(Color("WarmIvory"))
}
