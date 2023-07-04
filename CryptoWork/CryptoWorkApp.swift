//
//  CryptoWorkApp.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

@main
struct CryptoWorkApp: App {
    var body: some Scene {
        WindowGroup {
            CryptoListScreen()
                .onAppear {
                    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
            }
        }
    }
}
