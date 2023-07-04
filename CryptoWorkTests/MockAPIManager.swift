//
//  MockAPIManager.swift
//  CryptoWorkTests
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation
@testable import CryptoWork
import Combine

class MockAPIManager: IAPIManager {
    func fetchList() -> AnyPublisher<CryptoListData, CryptoWorkError> {
        return Just(CryptoListData.dummy)
            .setFailureType(to: CryptoWorkError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchItem(id: String) -> AnyPublisher<CryptoSingleData, CryptoWorkError> {
        return Just(CryptoSingleData.dummy)
            .setFailureType(to: CryptoWorkError.self)
            .eraseToAnyPublisher()
    }
    
    
}
