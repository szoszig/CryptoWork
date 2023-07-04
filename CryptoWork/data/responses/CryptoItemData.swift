//
//  CryptoItemData.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation

struct CryptoItemData: Decodable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?
}
