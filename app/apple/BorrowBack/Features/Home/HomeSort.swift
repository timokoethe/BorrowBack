//
//  HomeSort.swift
//  BorrowBack
//
//  Created by Codex on 20.08.26.
//

enum HomeSort: String, CaseIterable, Hashable, Identifiable {
    case dueDate
    case name

    var id: Self { self }

    var title: String {
        switch self {
        case .dueDate:
            "Fälligkeitsdatum"
        case .name:
            "Name"
        }
    }
}
