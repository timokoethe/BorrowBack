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

    var body: some View {
        content
            .background(
                ContactPickerPresenter(isPresented: $isShowingContactPicker) {
                    borrower = $0
                }
            )
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
                .tint(Color("BBTeal"))
                .accessibilityLabel("Choose contact")
            }
        case .contact(_, let name):
            HStack(spacing: 12) {
                Label(name, systemImage: "person.crop.circle.fill")
                    .foregroundStyle(Color("DeepInk"))
                    .lineLimit(1)

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
}

#Preview {
    @Previewable @State var freeText = Borrower.empty
    @Previewable @State var linked = Borrower.contact(
        identifier: "preview",
        name: "Tobias Wagner"
    )

    Form {
        Section("Person") {
            BorrowerField(borrower: $freeText)
            BorrowerField(borrower: $linked)
        }
    }
}
