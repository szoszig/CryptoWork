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
            ZStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .data(let data):
                    if data.isEmpty {
                        EmptyScreen()
                    } else {
                        ScrollView {
                            VStack (spacing: 16) {
                                ForEach(data, id: \.self) { item in
                                    NavigationLink(destination: CryptoDetailScreen(data: item)) {
                                        CryptoListItemView(data: item)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                case .error:
                    ErrorScreen(error: .mappingError) {
                        viewModel.fetchData()
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .applyCommonGradientBackground()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        navbarTitle
                    }
                }
        }.onAppear {
            viewModel.fetchData()
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
