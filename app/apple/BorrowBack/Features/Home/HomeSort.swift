//
//  HomeSort.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

import SwiftUI

enum HomeSort: String, CaseIterable, Hashable, Identifiable {
    case dueDate
    case name

    var id: Self { self }

    var title: LocalizedStringKey {
        switch self {
        case .dueDate:
            "Due date"
        case .name:
            "Name"
        }
    }
}
