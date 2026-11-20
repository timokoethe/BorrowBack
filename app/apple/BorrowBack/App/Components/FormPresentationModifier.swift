//
//  FormPresentationModifier.swift
//  BorrowBack
//
//  Created by Timo Köthe on 20.11.26.
//

import SwiftUI

/// Fits a centered sheet to its preferred height while preserving compact detents.
struct FormPresentationModifier: ViewModifier {
    // Read from the presenting window; a form sheet can itself have compact width.
    let isExpanded: Bool
    @ScaledMetric private var preferredHeight: CGFloat

    init(isExpanded: Bool, preferredHeight: CGFloat) {
        self.isExpanded = isExpanded
        _preferredHeight = ScaledMetric(wrappedValue: preferredHeight, relativeTo: .body)
    }

    func body(content: Content) -> some View {
        content
            .frame(idealHeight: isExpanded ? preferredHeight : nil)
            .presentationSizing(.form.fitted(horizontal: false, vertical: true))
            .presentationDetents(isExpanded ? [.large] : [.medium, .large])
            .presentationDragIndicator(isExpanded ? .hidden : .visible)
    }
}

extension View {
    func formPresentation(isExpanded: Bool, preferredHeight: CGFloat = 780) -> some View {
        modifier(FormPresentationModifier(isExpanded: isExpanded, preferredHeight: preferredHeight))
    }
}
