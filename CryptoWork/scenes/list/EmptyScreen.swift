//
//  EmptyScreen.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct EmptyScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "text.magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("aldi_black"))
                .frame(width: 145, height: 143)
            Text("No result")
                .font(.custom("Poppins-Bold", size: 30))
                .foregroundColor(Color("aldi_black"))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .applyCommonGradientBackground()
    }
}

struct EmptyScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyScreen()
    }
}
