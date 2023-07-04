//
//  APIManager.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation
import Combine

protocol IAPIManager {
    func fetchList() -> AnyPublisher<CryptoListData, CryptoWorkError>
    func fetchItem(id: String) -> AnyPublisher<CryptoSingleData, CryptoWorkError>
}

class APIManager: IAPIManager {
    static let shared = APIManager()
    
    private init() { }
    
    func fetchList() -> AnyPublisher<CryptoListData, CryptoWorkError> {
        return fetch(
            urlString: "https://api.coincap.io/v2/assets",
            queryItems: [URLQueryItem(name: "limit", value: "\(Constants.topCryptoLimit)")]
        )
    }
    
    func fetchItem(id: String) -> AnyPublisher<CryptoSingleData, CryptoWorkError> {
        return fetch(urlString: "https://api.coincap.io/v2/assets/\(id)")
    }
    
    private func fetch<Data: Decodable>(urlString: String, queryItems: [URLQueryItem] = []) -> AnyPublisher<Data, CryptoWorkError> {
        guard var url = URL(string: urlString) else {
            return Fail(error: CryptoWorkError.invalidRequest("invalid url")).eraseToAnyPublisher()
        }
        if !queryItems.isEmpty {
            url.append(queryItems: queryItems)
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { CryptoWorkError.transportError($0) }
            .map(\.data)
            .decode(type: Data.self, decoder: JSONDecoder())
            .mapError { error in CryptoWorkError.mappingError }
            .eraseToAnyPublisher()
        }
}
