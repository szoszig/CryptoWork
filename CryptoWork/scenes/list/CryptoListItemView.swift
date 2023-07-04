//
//  CryptoListItemView.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct CryptoListItemView: View {
    let data: CryptoItem
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            HStack(spacing: 16) {
                logo
                names
                Spacer()
                values
            }
            Image(systemName: "arrow.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(2)
                .frame(width: 24, height: 24)
                .foregroundColor(Color("aldi_black"))
        }
        .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 16))
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color("aldi_white"))
        )
        .padding(.horizontal, 16)
    }
}

extension CryptoListItemView {
    private var logo: some View {
        CryptoLogo(symbolName: data.symbol)
            .frame(width: 56, height: 56)
    }
    
    private var names: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(data.name)
                .font(.custom("Poppins-Bold", size: 20))
                .frame(height: 14)
            Text(data.symbol)
                .font(.custom("Poppins-Regular", size: 16))
                .frame(height: 11)
        }
        .foregroundColor(Color("aldi_black"))
    }
    
    private var values: some View {
        VStack(alignment: .trailing, spacing: 16) {
            Text(data.priceUsd.largeNumFormatted())
                .font(.custom("Poppins-Bold", size: 16))
                .foregroundColor(Color("aldi_black"))
                .frame(height: 11)
            ratioIndicator
                .frame(height: 11)
        }
    }
    
    private var ratioIndicator: some View {
        return Text(data.change.formattedTwoDigitValue + "%")
                .font(.custom("Poppins-Bold", size: 16))
                .foregroundColor(data.changeType.color)
    }
    
    private func indicator(_ color: Color) -> some View {
        Image(systemName: "triangle.fill")
            .resizable()
            .foregroundColor(color)
            .aspectRatio(contentMode: .fit)
                .frame(width: 8, height: 8)
    }
}

struct CryptoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListItemView(
            data: CryptoItem(
                id: "id",
                name: "name",
                symbol: "BTC",
                priceUsd: 12.3,
                change: 1.2,
                marketCap: 1.1,
                volume: 1.3,
                supply: 3.3,
                changeType: .down
            )
        )
    }
}
