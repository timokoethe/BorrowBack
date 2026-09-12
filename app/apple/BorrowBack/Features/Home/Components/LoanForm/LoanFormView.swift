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
    /// The earliest date the due date picker offers. A new loan cannot be due
    /// in the past, while an existing one may already be overdue.
    let earliestDueDate: Date
    /// Whether the title field takes focus when the form appears.
    let focusesTitle: Bool
    let presentationStyle: PresentationStyle
    let onSave: () -> Void

    @Environment(\.currentDay) private var currentDay
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTitleFocused: Bool
    @State private var dueDatePreset = DueDatePreset.fourteenDays

    var body: some View {
        Form {
            Section("Loan") {
                TextField("What did you lend?", text: $draft.title)
                    .focused($isTitleFocused)
            }

            Section("Person") {
                BorrowerField(borrower: $draft.borrower)
            }

            Section("Return") {
                DatePicker(
                    "Due on",
                    selection: $draft.dueDate,
                    in: earliestDueDate...,
                    displayedComponents: .date
                )

                if presentationStyle == .pushed {
                    HStack(spacing: 8) {
                        dueDatePresetButton("7 days", preset: .sevenDays)
                        dueDatePresetButton("14 days", preset: .fourteenDays)
                        dueDatePresetButton("Custom date", preset: .custom)
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
        .onAppear {
            if focusesTitle {
                isTitleFocused = true
            }

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
        .onChange(of: currentDay) {
            if presentationStyle == .pushed,
               let updatedDate = date(for: dueDatePreset) {
                draft.dueDate = updatedDate
            }
        }
    }

    private func matchingPreset(for dueDate: Date) -> DueDatePreset {
        let calendar = Calendar.current

        if let sevenDaysFromNow = date(for: .sevenDays),
           calendar.isDate(dueDate, inSameDayAs: sevenDaysFromNow) {
            return .sevenDays
        }

        if let fourteenDaysFromNow = date(for: .fourteenDays),
           calendar.isDate(dueDate, inSameDayAs: fourteenDaysFromNow) {
            return .fourteenDays
        }

        return .custom
    }

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
            to: currentDay
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
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .foregroundStyle(
                    isSelected ? Color("AccentForeground") : Color("DeepInk").opacity(0.7)
                )
                .frame(maxWidth: .infinity)
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
        earliestDueDate: .now,
        focusesTitle: true,
        presentationStyle: .pushed,
        onSave: {}
    )
}
