//
//  OnboardingView.swift
//  BorrowBack
//
//  Created by Timo Köthe on 17.09.26.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.accessibilityReduceMotion) private var accessibilityReduceMotion
    @State private var isContentVisible = false
    @State private var isCompleting = false
    @State private var needsScrolling = false

    let onComplete: () -> Void

    init(onComplete: @escaping () -> Void = {}) {
        self.onComplete = onComplete
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    BorrowBackWordmark(animatesOnAppear: true)

                    Spacer(minLength: 44)

                    OnboardingLogoView()
                        .padding(.horizontal, 48)

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
                    .opacity(isContentVisible ? 1 : 0)
                    .offset(y: isContentVisible ? 0 : 10)
                    .animation(contentAnimation, value: isContentVisible)

                    Spacer(minLength: 28)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 28)
                .padding(.top, 28)
                .frame(minHeight: geometry.size.height)
            }
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize, axes: .vertical)
            .onScrollGeometryChange(for: Bool.self) { scrollGeometry in
                scrollGeometry.contentSize.height > geometry.size.height + 1
            } action: { _, needsScrolling in
                self.needsScrolling = needsScrolling
            }
            .scrollDisabled(!needsScrolling)
        }
        .safeAreaInset(edge: .bottom) {
            Button(action: completeOnboarding) {
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
            .disabled(isCompleting)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
        }
        .scaleEffect(isCompleting ? 0.96 : 1)
        .opacity(isCompleting ? 0 : 1)
        .background(Color("WarmIvory").ignoresSafeArea())
        .allowsHitTesting(!isCompleting)
        .onAppear {
            isContentVisible = true
        }
    }

    private var contentAnimation: Animation? {
        guard !accessibilityReduceMotion else { return nil }
        return .easeOut(duration: 0.42).delay(0.28)
    }

    private func completeOnboarding() {
        guard !isCompleting else { return }

        guard !accessibilityReduceMotion else {
            onComplete()
            return
        }

        withAnimation(
            .easeOut(duration: 0.16),
            completionCriteria: .logicallyComplete
        ) {
            isCompleting = true
        } completion: {
            onComplete()
        }
    }
}

#Preview {
    OnboardingView()
}
