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
    let onSelect: (BorrowerContactSelection) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ host: UIViewController, context: Context) {
        context.coordinator.onSelect = onSelect
        context.coordinator.onFinish = { isPresented = false }

        guard isPresented, host.presentedViewController == nil else { return }

        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        picker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        host.present(picker, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onSelect: onSelect, onFinish: { isPresented = false })
    }

    final class Coordinator: NSObject, CNContactPickerDelegate {
        var onSelect: (BorrowerContactSelection) -> Void
        var onFinish: () -> Void

        init(
            onSelect: @escaping (BorrowerContactSelection) -> Void,
            onFinish: @escaping () -> Void
        ) {
            self.onSelect = onSelect
            self.onFinish = onFinish
        }

        func contactPicker(
            _ picker: CNContactPickerViewController,
            didSelect contact: CNContact
        ) {
            let selection = BorrowerContactSelection(contact: contact)

            // Finish the UIKit transition before SwiftUI presents the number
            // choice. Presenting it while the picker still dims the underlying
            // navigation stack can leave the dialog's actions looking disabled.
            picker.dismiss(animated: true) { [self] in
                onFinish()

                if let selection {
                    onSelect(selection)
                }
            }
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            onFinish()
        }
    }
}

struct BorrowerContactSelection {
    struct PhoneNumber: Identifiable {
        let id = UUID()
        let label: String?
        let value: String
    }

    let identifier: String
    let name: String
    let phoneNumbers: [PhoneNumber]
    let photoData: Data?

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

        identifier = contact.identifier
        self.name = name
        photoData = Self.photoSnapshot(from: contact)
        phoneNumbers = contact.phoneNumbers.map { phoneNumber in
            let label = phoneNumber.label.flatMap { rawLabel -> String? in
                let trimmedLabel = rawLabel.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmedLabel.isEmpty else { return nil }
                return CNLabeledValue<NSString>.localizedString(forLabel: trimmedLabel)
            }

            return PhoneNumber(
                label: label,
                value: phoneNumber.value.stringValue
            )
        }
    }

    /// Only read image keys supplied by the picker. Never refetch the contact,
    /// which would require Contacts authorization. Store a small, metadata-free JPEG.
    private static func photoSnapshot(from contact: CNContact) -> Data? {
        let thumbnail = contact.isKeyAvailable(CNContactThumbnailImageDataKey)
            ? contact.thumbnailImageData : nil
        let data = thumbnail ?? (contact.isKeyAvailable(CNContactImageDataKey)
            ? contact.imageData : nil)
        guard let data,
              let image = UIImage(data: data),
              let thumbnail = image.preparingThumbnail(of: CGSize(width: 128, height: 128))
        else { return nil }

        return thumbnail.jpegData(compressionQuality: 0.8)
    }

    func borrower(phoneNumber: String?) -> Borrower {
        .contact(
            identifier: identifier,
            name: name,
            phoneNumber: phoneNumber,
            photoData: photoData
        )
    }
}
