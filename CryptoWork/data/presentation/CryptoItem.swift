//
//  CryptoItem.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation

struct CryptoItem: Hashable {
    let id: String
    let name: String
    let symbol: String
    let priceUsd: Double
    let change: Double
    let marketCap: Double
    let volume: Double
    let supply: Double
    let changeType: ChangeType
}
