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
                        Text(verbatim: "\(phoneNumber.label): \(phoneNumber.value)")
                    }
                }

                Button("Cancel", role: .cancel) {
                    pendingContact = nil
                }
            } message: { _ in
                Text("This number will be used for reminder messages.")
            }
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
                }
                .buttonStyle(.borderless)
                .accessibilityLabel("Choose contact")
            }
        case .contact(_, let name, let phoneNumber):
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Label(name, systemImage: "person.crop.circle.fill")
                        .foregroundStyle(Color("DeepInk"))
                        .lineLimit(1)

                    if let phoneNumber {
                        Text(phoneNumber)
                            .font(.caption)
                            .foregroundStyle(Color("DeepInk").opacity(0.6))
                            .lineLimit(1)
                    }
                }

                Spacer()

                Button {
                    borrower = .empty
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .buttonStyle(.borderless)
                .tint(Color("DeepInk").opacity(0.4))
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
