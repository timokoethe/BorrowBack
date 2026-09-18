//
//  OnboardingLogoView.swift
//  BorrowBack
//
//  Created by Codex on 18.09.26.
//

import SwiftUI

struct OnboardingLogoView: View {
    @Environment(\.accessibilityReduceMotion) private var accessibilityReduceMotion
    @State private var isVisible = false

    var body: some View {
        GeometryReader { geometry in
            let length = min(geometry.size.width, geometry.size.height)

            ZStack {
                RoundedRectangle(
                    cornerRadius: length * 0.19,
                    style: .continuous
                )
                .fill(Color("CardSurface"))
                .shadow(
                    color: Color("DeepInk").opacity(0.08),
                    radius: length * 0.1,
                    y: length * 0.05
                )

                Circle()
                    .fill(Color("BBTeal").opacity(0.12))
                    .padding(14)
                    .scaleEffect(isVisible ? 1 : 0.72)
                    .opacity(isVisible ? 1 : 0)
                    .animation(entranceAnimation(delay: 0.08), value: isVisible)

                ZStack {
                    RoundedRectangle(
                        cornerRadius: length * 0.18,
                        style: .continuous
                    )
                    .fill(Color("BBTeal"))
                    .shadow(
                        color: Color("BBTeal").opacity(0.22),
                        radius: length * 0.06,
                        y: length * 0.035
                    )

                    Image("BorrowBackLogo")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundStyle(Color("AccentForeground"))
                        .padding(29)
                }
                .padding(28)
                .rotationEffect(.degrees(isVisible ? 0 : -7))
                .scaleEffect(isVisible ? 1 : 0.82)
                .opacity(isVisible ? 1 : 0)
                .animation(entranceAnimation(delay: 0.14), value: isVisible)
            }
            .frame(width: length, height: length)
        }
        .aspectRatio(1, contentMode: .fit)
        .scaleEffect(isVisible ? 1 : 0.96)
        .opacity(isVisible ? 1 : 0)
        .animation(entranceAnimation(), value: isVisible)
        .accessibilityHidden(true)
        .onAppear {
            isVisible = true
        }
    }

    private func entranceAnimation(delay: TimeInterval = 0) -> Animation? {
        guard !accessibilityReduceMotion else { return nil }
        return .spring(duration: 0.55, bounce: 0.18).delay(delay)
    }
}

#Preview {
    OnboardingLogoView()
        .padding()
        .background(Color("WarmIvory"))
}
