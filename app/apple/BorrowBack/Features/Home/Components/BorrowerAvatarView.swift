//
//  BorrowerAvatarView.swift
//  BorrowBack
//
//  Created by Codex on 16.11.26.
//

import SwiftUI
import UIKit

/// A decorative photo beside the borrower's name, with the existing symbol as fallback.
struct BorrowerAvatarView: View {
    let photoData: Data?
    let fallbackSymbol: String
    let size: CGFloat

    @State private var image: UIImage?

    var body: some View {
        Image(systemName: fallbackSymbol)
            .font(.system(size: size))
            .opacity(image == nil ? 1 : 0)
            .overlay {
                if let image {
                    GeometryReader { geometry in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipShape(Circle())
                    }
                }
            }
            .accessibilityHidden(true)
            .task(id: photoData) {
                image = photoData.flatMap { UIImage(data: $0) }
            }
    }
}
