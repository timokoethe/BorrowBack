//
//  BorrowerField.swift
//  BorrowBack
//
//  Created by Claude on 08.09.26.
//

import SwiftUI

/// Form row for the borrower of a loan. Typing a name is the default path;
/// the button next to it links a system contact instead. A linked contact is
/// removed again to return to free-text entry.
struct BorrowerField: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @ScaledMetric(relativeTo: .body) private var contactIconSize = 24.0

    @Binding var borrower: Borrower

    @State private var isShowingContactPicker = false
    @State private var isChoosingPhoneNumber = false
    @State private var pendingContact: BorrowerContactSelection?

    var body: some View {
        content
            .background(
                ContactPickerPresenter(isPresented: $isShowingContactPicker) {
                    handleContactSelection($0)
                }
            )
            .confirmationDialog(
                "Choose a phone number",
                isPresented: $isChoosingPhoneNumber,
                titleVisibility: .visible,
                presenting: pendingContact
            ) { selection in
                ForEach(selection.phoneNumbers) { phoneNumber in
                    Button {
                        borrower = selection.borrower(phoneNumber: phoneNumber.value)
                        pendingContact = nil
                    } label: {
                        if let label = phoneNumber.label {
                            Text(verbatim: "\(label): \(phoneNumber.value)")
                        } else {
                            Text(verbatim: phoneNumber.value)
                        }
                    }
                }

                Button("Cancel", role: .cancel) {
                    pendingContact = nil
                }
            } message: { _ in
                Text("This number will be used for reminder messages.")
            }
            .tint(isChoosingPhoneNumber ? .primary : nil)
    }

    @ViewBuilder
    private var content: some View {
        switch borrower {
        case .name:
            HStack(spacing: 12) {
                TextField("Name", text: nameBinding)
                    .textContentType(.name)

                Button {
                    isShowingContactPicker = true
                } label: {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: contactIconSize))
                        .frame(minWidth: 44, minHeight: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)
                .accessibilityLabel("Choose contact")
            }
        case .contact(_, let name, let phoneNumber):
            HStack(spacing: 12) {
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: contactIconSize))
                        .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(verbatim: name)
                            .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                            .fixedSize(horizontal: false, vertical: true)

                        if let phoneNumber {
                            Text(verbatim: phoneNumber)
                                .font(.caption)
                                .foregroundStyle(Color("DeepInk").opacity(0.7))
                                .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 1)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .foregroundStyle(Color("DeepInk"))

                Spacer()

                Button {
                    borrower = .empty
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: contactIconSize))
                        .frame(minWidth: 44, minHeight: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)
                .tint(Color("DeepInk").opacity(0.7))
                .accessibilityLabel("Remove contact")
            }
        }
    }

    /// Keeps typed text in the free-text case. The contact case never renders
    /// the text field, so editing cannot silently break a contact link.
    private var nameBinding: Binding<String> {
        Binding(
            get: { borrower.displayName },
            set: { borrower = .name($0) }
        )
    }

    private func handleContactSelection(_ selection: BorrowerContactSelection) {
        switch selection.phoneNumbers.count {
        case 0:
            borrower = selection.borrower(phoneNumber: nil)
        case 1:
            borrower = selection.borrower(phoneNumber: selection.phoneNumbers[0].value)
        default:
            pendingContact = selection
            isChoosingPhoneNumber = true
        }
    }
}

#Preview {
    @Previewable @State var freeText = Borrower.empty
    @Previewable @State var linked = Borrower.contact(
        identifier: "preview",
        name: "Tobias Wagner",
        phoneNumber: "+49 151 23456789"
    )

    Form {
        Section("Person") {
            BorrowerField(borrower: $freeText)
            BorrowerField(borrower: $linked)
        }
    }
}
