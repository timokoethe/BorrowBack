//
//  ContactPickerPresenter.swift
//  BorrowBack
//
//  Created by Claude on 08.09.26.
//

import ContactsUI
import SwiftUI

/// Presents the system contact picker from UIKit and reports the selection.
///
/// The picker is deliberately not presented as a SwiftUI sheet: it dismisses
/// itself once the user selects or cancels, so a second dismissal driven by
/// SwiftUI would tear down the surrounding sheet as well. This presenter
/// therefore renders nothing and is attached as a background.
struct ContactPickerPresenter: UIViewControllerRepresentable {
    @Binding var isPresented: Bool

    /// Called with the selected contact. Not called when the user cancels or
    /// when the contact carries no usable name.
    let onSelect: (Borrower) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ host: UIViewController, context: Context) {
        context.coordinator.onSelect = onSelect
        context.coordinator.onFinish = { isPresented = false }

        guard isPresented, host.presentedViewController == nil else { return }

        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        host.present(picker, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onSelect: onSelect, onFinish: { isPresented = false })
    }

    final class Coordinator: NSObject, CNContactPickerDelegate {
        var onSelect: (Borrower) -> Void
        var onFinish: () -> Void

        init(onSelect: @escaping (Borrower) -> Void, onFinish: @escaping () -> Void) {
            self.onSelect = onSelect
            self.onFinish = onFinish
        }

        func contactPicker(
            _ picker: CNContactPickerViewController,
            didSelect contact: CNContact
        ) {
            if let borrower = Borrower(contact: contact) {
                onSelect(borrower)
            }

            onFinish()
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            onFinish()
        }
    }
}

extension Borrower {
    /// Links a picked contact, preferring its formatted name and falling back
    /// to the organization. Returns `nil` for a contact without any usable
    /// name, because a loan cannot be saved without one.
    init?(contact: CNContact) {
        let formattedName = CNContactFormatter.string(from: contact, style: .fullName)
        let candidates = [formattedName, contact.organizationName]

        guard let name = candidates
            .compactMap({ $0?.trimmingCharacters(in: .whitespacesAndNewlines) })
            .first(where: { !$0.isEmpty })
        else {
            return nil
        }

        self = .contact(identifier: contact.identifier, name: name)
    }
}
