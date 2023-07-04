//
//  CryptoListViewModel.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation
import Combine

class CryptoListViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case data([CryptoItem])
        case error(CryptoWorkError)
    }
    @Published var viewState: CryptoListViewModel.State = .loading
    
    private var apiManager: IAPIManager
    
    init(apiManager: IAPIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func fetchData() {
        viewState = .loading
        
        apiManager.fetchList()
            .map {
                $0.data.map { item in
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
            }
            .map {
                State.data($0)
            }
            .catch{
                Just(CryptoListViewModel.State.error($0))
            }
            .receive(on: RunLoop.main)
            .assign(to: &$viewState)
    }
}
