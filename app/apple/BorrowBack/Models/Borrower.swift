//
//  Borrower.swift
//  BorrowBack
//
//  Created by Claude on 08.09.26.
//

import Foundation

/// The person a loan is assigned to: either a free-text name or a linked
/// system contact. The two are mutually exclusive, so a form can never hold
/// both a typed name and a contact link at the same time.
enum Borrower: Equatable {
    case name(String)
    case contact(identifier: String, name: String, phoneNumber: String?, photoData: Data? = nil)

    /// An unset borrower, ready for free-text entry.
    static let empty = Borrower.name("")

    /// Rebuilds the borrower of a persisted loan, which stores the name and
    /// the optional contact link in separate fields.
    init(name: String, contactIdentifier: String?, phoneNumber: String?, photoData: Data? = nil) {
        if let contactIdentifier {
            self = .contact(
                identifier: contactIdentifier,
                name: name,
                phoneNumber: phoneNumber,
                photoData: photoData
            )
        } else {
            self = .name(name)
        }
    }

    /// Name shown in the interface and persisted with the loan.
    var displayName: String {
        switch self {
        case .name(let name):
            name
        case .contact(_, let name, _, _):
            name
        }
    }

    /// Identifier of the linked contact, `nil` for a free-text name.
    var contactIdentifier: String? {
        switch self {
        case .name:
            nil
        case .contact(let identifier, _, _, _):
            identifier
        }
    }

    /// Phone number retained for composing reminders. BorrowBack stores only
    /// this one number, not the contact's complete address book entry.
    var phoneNumber: String? {
        switch self {
        case .name:
            nil
        case .contact(_, _, let phoneNumber, _):
            phoneNumber
        }
    }

    /// A snapshot of the selected contact's photo, never loaded from Contacts at launch.
    var photoData: Data? {
        switch self {
        case .name:
            nil
        case .contact(_, _, _, let photoData):
            photoData
        }
    }

    /// The name as it is persisted, without surrounding whitespace.
    var persistedName: String {
        displayName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Whether the borrower can be saved with a loan.
    var isValid: Bool {
        !persistedName.isEmpty
    }
}
