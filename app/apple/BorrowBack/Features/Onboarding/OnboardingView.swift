//
//  OnboardingView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 17.09.26.
//

import SwiftUI

struct OnboardingView: View {
    let onComplete: () -> Void

    init(onComplete: @escaping () -> Void = {}) {
        self.onComplete = onComplete
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    BorrowBackWordmark()

                    Spacer(minLength: 44)

                    heroIllustration

                    Spacer(minLength: 40)

                    VStack(spacing: 14) {
                        Text("Everything you lend, right where you need it.")
                            .font(.largeTitle.weight(.bold))
                            .foregroundStyle(Color("DeepInk"))
                            .multilineTextAlignment(.center)

                        Text("Keep track of every loan, due date, and return in one calm place.")
                            .font(.body)
                            .foregroundStyle(Color("DeepInk").opacity(0.68))
                            .multilineTextAlignment(.center)
                            .lineSpacing(3)
                    }

                    Spacer(minLength: 128)
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: geometry.size.height)
                .padding(.horizontal, 28)
                .padding(.top, 28)
            }
            .scrollIndicators(.hidden)
        }
        .safeAreaInset(edge: .bottom) {
            Button(action: onComplete) {
                HStack {
                    Text("Get started")
                        .fontWeight(.semibold)

                    Spacer()

                    Image(systemName: "arrow.right")
                        .font(.body.weight(.semibold))
                }
                .padding(.horizontal, 4)
            }
            .buttonStyle(.glassProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
        }
        .background(Color("WarmIvory"))
    }

    private var heroIllustration: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 44, style: .continuous)
                .fill(Color("CardSurface"))
                .shadow(color: Color("DeepInk").opacity(0.08), radius: 24, y: 12)

            Circle()
                .fill(Color("BBTeal").opacity(0.12))
                .frame(width: 142, height: 142)

            Image(systemName: "shippingbox.fill")
                .font(.system(size: 72, weight: .medium))
                .foregroundStyle(Color("BBTeal"))
                .symbolRenderingMode(.hierarchical)

            Image(systemName: "arrow.uturn.backward.circle.fill")
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(Color("BBTeal"), Color("CardSurface"))
                .offset(x: 72, y: 70)
        }
        .frame(width: 232, height: 232)
        .accessibilityHidden(true)
    }
}

#Preview {
    OnboardingView()
}
