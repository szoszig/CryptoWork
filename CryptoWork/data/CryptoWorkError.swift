//
//  CryptoWorkError.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation

enum CryptoWorkError: LocalizedError {
    case invalidRequest(String)
    case transportError(Error)
    case mappingError
}
