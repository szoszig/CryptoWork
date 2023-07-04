//
//  CryptoDetailViewModel.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation
import Combine

class CryptoDetailViewModel: ObservableObject {
    enum State: Equatable {
        case data(CryptoItem?, Bool)
        case error
    }
    @Published var viewState: CryptoDetailViewModel.State = .data(nil, true)
    
    private var apiManager: IAPIManager
    
    init(apiManager: IAPIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func fetchData(data: CryptoItem) {
        viewState = .data(data, true)
        apiManager.fetchItem(id: data.id)
            .map { $0.data }
            .map { item in
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
            .map {
                State.data($0, false)
            }.replaceError(with: CryptoDetailViewModel.State.error)
            .receive(on: RunLoop.main)
            .assign(to: &$viewState)
    }
}
