//
//  ContentWidthModifier.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.11.26.
//

import SwiftUI

/// Keeps compact layouts unchanged and centers readable content in wider windows.
struct ContentWidthModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let maximum: CGFloat

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: horizontalSizeClass == .regular ? maximum : .infinity)
            .frame(maxWidth: .infinity)
    }
}

extension View {
    func contentWidth(maximum: CGFloat) -> some View {
        modifier(ContentWidthModifier(maximum: maximum))
    }
}
