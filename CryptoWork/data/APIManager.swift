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
            urlString: Constants.endpoint,
            queryItems: [URLQueryItem(name: "limit", value: "\(Constants.topCryptoLimit)")]
        )
    }
    
    func fetchItem(id: String) -> AnyPublisher<CryptoSingleData, CryptoWorkError> {
        return fetch(urlString: Constants.endpoint + "/\(id)")
    }
    
    private func fetch<Data: Decodable>(urlString: String, queryItems: [URLQueryItem] = []) -> AnyPublisher<Data, CryptoWorkError> {
        guard Reachability.isConnectedToNetwork() else {
            return Fail(error: CryptoWorkError.offline).eraseToAnyPublisher()
        }
        
        guard var urlComponents = URLComponents(string: urlString) else {
            return Fail(error: CryptoWorkError.invalidRequest("invalid url")).eraseToAnyPublisher()
        }
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            return Fail(error: CryptoWorkError.invalidRequest("invalid url")).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { _ in CryptoWorkError.transportError }
            .map(\.data)
            .decode(type: Data.self, decoder: JSONDecoder())
            .mapError { error in CryptoWorkError.mappingError }
            .eraseToAnyPublisher()
        }
}
