//
//  BackgroundViewModifier.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct BackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(
            LinearGradient(
                colors: [
                    Color("aldi_turquoise"),
                    Color("aldi_blue")
                ],
                startPoint: .top,
                endPoint: .bottom
            ).opacity(0.3)
        )
    }
}

extension View {
    func applyCommonGradientBackground() -> some View {
        modifier(BackgroundViewModifier())
    }
}
