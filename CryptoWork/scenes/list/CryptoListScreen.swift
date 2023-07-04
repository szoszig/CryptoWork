//
//  CryptoListScreen.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct CryptoListScreen: View {
    @StateObject private var viewModel = CryptoListViewModel()
    
    var body: some View {
        NavigationView {
            if let error = viewModel.cryptoError {
                ErrorScreen(error: error) {
                    viewModel.fetchData()
                }
            } else {
                if viewModel.list.isEmpty {
                    EmptyScreen()
                } else {
                    ScrollView {
                        VStack (spacing: 16) {
                            ForEach(viewModel.list, id: \.self) { item in
                                NavigationLink(destination: CryptoDetailScreen(data: item)) {
                                    CryptoListItemView(data: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .applyCommonGradientBackground()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            navbarTitle
                        }
                    }
                }
            }
        }
    }
}

extension CryptoListScreen {
    var navbarTitle: some View {
        Text("COINS")
            .font(.custom("Poppins-Bold", size: 32))
            .foregroundColor(Color("aldi_black"))
    }
}

struct CryptoListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListScreen()
    }
}
