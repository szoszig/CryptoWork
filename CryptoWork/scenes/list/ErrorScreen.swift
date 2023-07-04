//
//  ErrorScreen.swift
//  CryptoWork
//
//  Created by Gergely Szoke on 2023. 07. 04..
//

import SwiftUI

struct ErrorScreen: View {
    let error: CryptoWorkError
    let callback: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "wifi.exclamationmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("aldi_black"))
                .frame(width: 145, height: 143)
            Text("Connection Error")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color("aldi_black"))
            Text(error.localizedDescription)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(Color("aldi_black"))
            
            Button {
                callback()
            } label: {
                HStack {
                    Image(systemName: "return")
                        .foregroundColor(.white)
                    Text("Retry").foregroundColor(.white)
                        .font(.system(size: 17, weight: .semibold))
                }
                .padding(.vertical, 10)
                .padding(.horizontal,40)
                .background(
                    RoundedRectangle(cornerRadius: 5))
            }.padding(.top, 30)
            Spacer()
            Text("Reason")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color("aldi_black"))
                .padding(.bottom, 20)
        }.padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .applyCommonGradientBackground()
    }
}

struct ErrorScreen_Previews: PreviewProvider {
    static var previews: some View {
        ErrorScreen(error: .mappingError, callback: {})
    }
}
