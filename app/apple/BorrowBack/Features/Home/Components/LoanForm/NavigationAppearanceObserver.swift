//
//  NavigationAppearanceObserver.swift
//  BorrowBack
//
//  Created by Codex on 17.09.26.
//

import SwiftUI
import UIKit

/// Reports when its containing navigation destination has finished appearing.
struct NavigationAppearanceObserver: UIViewControllerRepresentable {
    let onDidAppear: () -> Void

    func makeUIViewController(context: Context) -> ObserverViewController {
        ObserverViewController(onDidAppear: onDidAppear)
    }

    func updateUIViewController(
        _ uiViewController: ObserverViewController,
        context: Context
    ) {
        uiViewController.onDidAppear = onDidAppear
    }
}

final class ObserverViewController: UIViewController {
    var onDidAppear: () -> Void

    init(onDidAppear: @escaping () -> Void) {
        self.onDidAppear = onDidAppear
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        self.view = view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onDidAppear()
    }
}
