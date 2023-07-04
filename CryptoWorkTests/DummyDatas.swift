//
//  DummyDatas.swift
//  CryptoWorkTests
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

@testable import CryptoWork

extension CryptoItem {
    static func dummy(id: String = "BTC") -> Self {
        CryptoItem(
            id: id,
            name: "BTC",
            symbol: "BTC",
            priceUsd: 100.0,
            change: -0.5,
            marketCap: 1000.0,
            volume: 1000.0,
            supply: 1000.0,
            changeType: .down
        )
    }
}

extension CryptoSingleData {
    static let dummy: Self =
        CryptoSingleData(data: CryptoItemData.dummy())
}

extension CryptoItemData {
    static func dummy(rank: Int = 1) -> Self {
        CryptoItemData(
            id: "BTC",
            rank: "\(rank)",
            symbol: "BTC",
            name: "BTC",
            supply: "1000",
            maxSupply: nil,
            marketCapUsd: "1000",
            volumeUsd24Hr: "1000",
            priceUsd: "100",
            changePercent24Hr: "-0.5",
            vwap24Hr: nil,
            explorer: nil
        )
    }
}

extension CryptoListData {
    static let dummy: Self =
        CryptoListData(data: (1...10).map { CryptoItemData.dummy(rank: $0) })
}
