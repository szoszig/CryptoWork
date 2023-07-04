//
//  CryptoDetailScreen.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct CryptoDetailScreen: View {
    @ObservedObject var viewModel = CryptoDetailViewModel()
    let data: CryptoItem
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .error:
                ErrorScreen(error: .mappingError) {
                    viewModel.fetchData(data: data)
                }
            case .data(let data, let isLoading):
                content(data, isLoading)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    navbarTitle
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    CryptoLogo(symbolName: data.symbol)
                        .frame(width: 40, height: 40)
                }
            }
            .applyCommonGradientBackground()
            .onAppear {
                viewModel.fetchData(data: data)
            }
    }
}

extension CryptoDetailScreen {
    private var navbarTitle: some View {
        Text(data.name)
            .font(.custom("Poppins-Bold", size: 32))
            .foregroundColor(Color("aldi_black"))
    }
    
    private func content(_ data: CryptoItem?, _ isLoading: Bool) -> some View {
        VStack(spacing: 16) {
            if let data {
                CryptoDetailRowView(
                    title: "Price",
                    valueText: Text(data.priceUsd.largeNumFormatted())
                )
                CryptoDetailRowView(
                    title: "Change (24hr)",
                    valueText: Text(data.change.formattedTwoDigitValue + "%"),
                    valueColor: data.changeType.color
                )
                Divider()
                    .background(Color("aldi_blue"))
                    .padding(.vertical, 8)
                CryptoDetailRowView(
                    title: "Market Cap",
                    valueText: Text(data.marketCap.largeNumFormatted())
                )
                CryptoDetailRowView(
                    title: "Volume (24hr)",
                    valueText: Text(data.volume.largeNumFormatted())
                )
                CryptoDetailRowView(
                    title: "Supply",
                    valueText: Text(data.supply.largeNumFormatted(dollarSignRequired: false))
                )
            }
            Spacer(minLength: 0)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color("aldi_white"))
                
        )
        .overlay(
            isLoading ?
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("aldi_white").opacity(0.7))
                ProgressView()
            }
            : nil
        )
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
    }
}

struct CryptoDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailScreen(
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
