//
//  CryptoWorkError.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation

enum CryptoWorkError: LocalizedError, Equatable {
    case offline
    case invalidRequest(String)
    case transportError
    case mappingError
    
    var title: String {
        switch self {
        case .offline:
            return "No internet connection"
        case .invalidRequest(_):
            return "Invalid request"
        case .transportError:
            return "Transport error"
        case .mappingError:
            return "Data mapping failed"
        }
    }
    var imageName: String {
        switch self {
        case .offline:
            return "wifi.exclamationmark"
        default:
            return "wrongwaysign"
        }
    }
}
