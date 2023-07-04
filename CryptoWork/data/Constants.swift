//
//  Constants.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation

enum Constants {
    static let topCryptoLimit = 10
    static let endpoint = "https://api.coincap.io/v2/assets"
    
    enum Number {
        static let thousand = 1000.0
        static let million = 1000000.0
        static let billion = 1000000000.0
    }
}
