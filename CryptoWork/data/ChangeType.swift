//
//  ChangeType.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

enum ChangeType: Equatable {
    case up
    case down
    case stationary
    
    var color: Color {
        switch self {
        case .up:
            return Color("aldi_green")
        case .down:
            return Color("aldi_red")
        case .stationary:
            return Color("aldi_black")
        }
    }
    
    static func getType(value: Double) -> ChangeType {
        switch value {
        case 0:
            return .stationary
        case 0...Double.infinity:
            return .up
        default:
            return .down
        }
    }
}
