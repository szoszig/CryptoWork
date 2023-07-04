//
//  Double+extension.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import Foundation

extension Double {
    static var numberTwoDigitFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    var formattedTwoDigitValue: String {
        return Self.numberTwoDigitFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func largeNumFormatted(dollarSignRequired: Bool = true) -> String {
        let format = dollarSignRequired ? "$%.2f" : "%.2f"
        switch self {
        case 0..<Constants.Number.thousand:
            return String(format: format, self)
        case Constants.Number.thousand..<Constants.Number.million:
            return String(format: format + "K", self / Constants.Number.thousand)
        case Constants.Number.million..<Constants.Number.billion:
            return String(format: format + "M", self / Constants.Number.million)
        default:
            return String(format: format + "B", self / Constants.Number.billion)
        }
    }
}
