//
//  BorrowBackWordmark.swift
//  BorrowBack
//
//  Created by Codex on 12.09.26.
//

import SwiftUI

/// The shared wordmark that anchors the app's primary tabs.
struct BorrowBackWordmark: View {
    @Environment(\.accessibilityReduceMotion) private var accessibilityReduceMotion
    @State private var isVisible = false

    private let animatesOnAppear: Bool

    init(animatesOnAppear: Bool = false) {
        self.animatesOnAppear = animatesOnAppear
    }

    var body: some View {
        Text("BorrowBack")
            .font(.system(size: 36, weight: .bold, design: .serif))
            .foregroundStyle(Color("DeepInk"))
            .opacity(isVisible || !animatesOnAppear ? 1 : 0)
            .offset(y: isVisible || !animatesOnAppear ? 0 : 4)
            .onAppear {
                guard animatesOnAppear else { return }

                if accessibilityReduceMotion {
                    isVisible = true
                } else {
                    withAnimation(.easeOut(duration: 0.25)) {
                        isVisible = true
                    }
                }
            }
    }
}

#Preview {
    BorrowBackWordmark()
        .padding()
        .background(Color("WarmIvory"))
}
