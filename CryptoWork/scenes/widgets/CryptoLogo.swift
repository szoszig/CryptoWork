//
//  CryptoLogo.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct CryptoLogo: View {
    let symbolName: String
    var body: some View {
        AsyncImage(
            url: URL(string: "https://assets.coincap.io/assets/icons/\(symbolName.lowercased())@2x.png"),
            transaction: .init(animation: .spring())) { result in
                switch result {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                default:
                    Capsule()
                        .fill(Color("aldi_black"))
                }
            }
    }
}

struct CryptoLogo_Previews: PreviewProvider {
    static var previews: some View {
        CryptoLogo(symbolName: "BTC")
    }
}
