//
//  LoanFormView.swift
//  BorrowBack
//
//  Created by Claude on 09.09.26.
//

import SwiftUI

/// The shared form behind creating and editing a loan. It collects changes in
/// a `LoanDraft` and reports the confirmation; persistence and error handling
/// belong to the flow that presents it.
struct LoanFormView: View {
    enum PresentationStyle {
        case pushed
        case sheet
    }

    private enum DueDatePreset: Hashable {
        case sevenDays
        case fourteenDays
        case custom
    }

    @Binding var draft: LoanDraft

    let navigationTitle: LocalizedStringKey
    /// Whether the title field takes focus when the form appears.
    let focusesTitle: Bool
    let presentationStyle: PresentationStyle
    let onSave: () -> Void

    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTitleFocused: Bool
    @State private var dueDatePreset = DueDatePreset.fourteenDays
    @State private var hasRequestedInitialFocus = false

    var body: some View {
        Form {
            Section("Loan") {
                TextField("What did you lend?", text: $draft.title)
                    .focused($isTitleFocused)

                DatePicker(
                    "Lent on",
                    selection: $draft.loanedAt,
                    in: ...Date.now,
                    displayedComponents: .date
                )
            }

            Section("Person") {
                BorrowerField(borrower: $draft.borrower)
                    .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 10))
            }

            Section("Return") {
                DatePicker(
                    "Due on",
                    selection: $draft.dueDate,
                    in: draft.loanedAt...,
                    displayedComponents: .date
                )

                if presentationStyle == .pushed {
                    dueDatePresetLayout {
                        dueDatePresetButton("7 days", preset: .sevenDays)
                        dueDatePresetButton("14 days", preset: .fourteenDays)
                        dueDatePresetButton("Custom date", preset: .custom)

                        if !dynamicTypeSize.isAccessibilitySize {
                            Spacer(minLength: 0)
                        }
                    }
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel("Due date")
                }
            }
        }
        .formStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(Color("WarmIvory"))
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(
            presentationStyle == .pushed ? .visible : .automatic,
            for: .navigationBar
        )
        .toolbar {
            if presentationStyle == .sheet {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Cancel")
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button {
                    onSave()
                } label: {
                    Image(systemName: "checkmark")
                        .fontWeight(.semibold)
                }
                .disabled(!draft.isValid)
                .accessibilityLabel("Save")
            }
        }
        .background {
            if focusesTitle {
                NavigationAppearanceObserver {
                    guard !hasRequestedInitialFocus else { return }

                    hasRequestedInitialFocus = true
                    isTitleFocused = true
                }
            }
        }
        .onAppear {
            if presentationStyle == .pushed {
                dueDatePreset = matchingPreset(for: draft.dueDate)
            }
        }
        .onChange(of: dueDatePreset) { _, newPreset in
            if let date = date(for: newPreset) {
                draft.dueDate = date
            }
        }
        .onChange(of: draft.dueDate) { _, newDate in
            if presentationStyle == .pushed {
                dueDatePreset = matchingPreset(for: newDate)
            }
        }
        .onChange(of: draft.loanedAt) {
            if presentationStyle == .pushed,
               let presetDate = date(for: dueDatePreset) {
                draft.dueDate = presetDate
            } else if draft.dueDate < draft.loanedAt {
                draft.dueDate = draft.loanedAt
            }
        }
    }

    private var dueDatePresetLayout: AnyLayout {
        dynamicTypeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: 8))
            : AnyLayout(HStackLayout(spacing: 8))
    }

    private func matchingPreset(for dueDate: Date) -> DueDatePreset {
        let calendar = Calendar.current

        if let sevenDaysAfterLoan = date(for: .sevenDays),
           calendar.isDate(dueDate, inSameDayAs: sevenDaysAfterLoan) {
            return .sevenDays
        }

        if let fourteenDaysAfterLoan = date(for: .fourteenDays),
           calendar.isDate(dueDate, inSameDayAs: fourteenDaysAfterLoan) {
            return .fourteenDays
        }

        return .custom
    }

    /// A preset due date is measured from the loan date, so a loan recorded
    /// after the fact keeps the term the preset promises.
    private func date(for preset: DueDatePreset) -> Date? {
        let numberOfDays: Int

        switch preset {
        case .sevenDays:
            numberOfDays = 7
        case .fourteenDays:
            numberOfDays = 14
        case .custom:
            return nil
        }

        return Calendar.current.date(
            byAdding: .day,
            value: numberOfDays,
            to: draft.loanedAt
        )
    }

    private func dueDatePresetButton(
        _ title: LocalizedStringKey,
        preset: DueDatePreset
    ) -> some View {
        let isSelected = dueDatePreset == preset

        return Button {
            dueDatePreset = preset
        } label: {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                .minimumScaleFactor(dynamicTypeSize.isAccessibilitySize ? 1 : 0.8)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(
                    isSelected ? Color("AccentForeground") : Color("DeepInk").opacity(0.7)
                )
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    isSelected ? Color.accentColor : Color("MistGray"),
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    @Previewable @State var draft = LoanDraft()

    LoanFormView(
        draft: $draft,
        navigationTitle: "New Loan",
        focusesTitle: true,
        presentationStyle: .pushed,
        onSave: {}
    )
}
