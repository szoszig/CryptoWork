//
//  CryptoListViewModel.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation
import Combine

class CryptoListViewModel: ObservableObject {
    @Published var list: [CryptoItem] = []
    @Published var cryptoError: CryptoWorkError?
    
    var subscriptions: Set<AnyCancellable> = []
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        APIManager.shared.fetchList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.cryptoError = error
                case .finished:
                    self.cryptoError = nil
                }
            }, receiveValue: { result in
                self.list = result.data.map { item in
                    let change = Double(item.changePercent24Hr ?? "0") ?? 0
                    return CryptoItem(
                        id: item.id,
                        name: item.name,
                        symbol: item.symbol,
                        priceUsd: Double(item.priceUsd) ?? 0,
                        change: change,
                        marketCap: Double(item.marketCapUsd ?? "0") ?? 0,
                        volume: Double(item.volumeUsd24Hr ?? "0") ?? 0,
                        supply: Double(item.supply) ?? 0,
                        changeType: ChangeType.getType(value: change)
                    )
                }
            }).store(in: &subscriptions)
    }
}
