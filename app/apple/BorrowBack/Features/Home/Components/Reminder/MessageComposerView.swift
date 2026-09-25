//
//  MessageComposerView.swift
//  BorrowBack
//
//  Created by Codex on 25.09.26.
//

import MessageUI
import SwiftUI

/// SwiftUI bridge for the system SMS/iMessage composer. The system keeps the
/// final send action under the user's control.
struct MessageComposerView: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss

    let message: LoanReminderMessage
    let onFailure: () -> Void

    static var canSendText: Bool {
        MFMessageComposeViewController.canSendText()
    }

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composer = MFMessageComposeViewController()
        composer.messageComposeDelegate = context.coordinator
        composer.recipients = [message.recipient]
        composer.body = message.body
        return composer
    }

    func updateUIViewController(
        _ composer: MFMessageComposeViewController,
        context: Context
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onFailure: onFailure, onFinish: dismiss)
    }

    final class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        private let onFailure: () -> Void
        private let onFinish: DismissAction

        init(onFailure: @escaping () -> Void, onFinish: DismissAction) {
            self.onFailure = onFailure
            self.onFinish = onFinish
        }

        func messageComposeViewController(
            _ controller: MFMessageComposeViewController,
            didFinishWith result: MessageComposeResult
        ) {
            if result == .failed {
                onFailure()
            }

            onFinish()
        }
    }
}
